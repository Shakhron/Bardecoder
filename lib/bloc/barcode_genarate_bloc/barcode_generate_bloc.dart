import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as im;
import 'dart:typed_data';
import 'package:barcode/barcode.dart';
import 'package:bloc/bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_extend/share_extend.dart';
part 'barcode_generate_event.dart';
part 'barcode_generate_state.dart';

class BarcodeGenerateBloc
    extends Bloc<BarcodeGenerateEvent, BarcodeGenerateState> {
  final String name;

  String barcodeImage = '';
  Barcode bc = Barcode.qrCode();
  bool error = false;
  String srterror = '';
  String fileType = 'png';
  double height = 110;
  double width = 110;
  int barcodeSize = 3;
  String savedFilePath = '';

  BarcodeGenerateBloc(this.name) : super(BarcodeGenerateInitial()) {
    bc = _barcodetype(name);
    barcodeImage = _buildBarcode(bc, '0' * bc.minLength);

    on<BuildBarcode>((event, emit) {
      try {
        final String svg = _buildBarcode(bc, event.data,
            height: event.height, width: event.width);
        barcodeImage = svg;
        error = false;
        emit(BarcodeBuildedSuccessful(svg));
      } catch (e) {
        error = true;
        emit(BarcodeBuildedFailure(e.toString()));
      }
    });

    on<ShareBarcode>((event, emit) async {
      File file = await saveFile(fileType, barcodeImage);

      if (!await file.exists()) {
        await file.create(recursive: true);
        file.writeAsStringSync("test for share documents file");
      }

      ShareExtend.share(file.path, "file");
    });

    on<BarcodeSizeChanged>((event, emit) {
      barcodeSize = event.barcodeSize;
      height = event.height.toDouble();
      width = event.width.toDouble();
      error
          ? _buildBarcode(bc, '0' * bc.minLength, height: height, width: width)
          : barcodeImage =
              _buildBarcode(bc, event.formText, height: height, width: width);
      emit(BarcodeSizeChangedState());
    });

    on<TypeChanged>((event, emit) {
      fileType = event.type;
      emit(BarcodeTypeChangedState());
    });

    on<SaveFile>((event, emit) => saveFile(event.type, event.svgString));
  }

  Uint8List addMarginsToPngFile(
      Uint8List file, int horizontalMargin, int verticalMargin) {
    im.Image? image = im.decodePng(file);
    int newWidth = image!.width + 2 * horizontalMargin;
    int newHeight = image.height + 2 * verticalMargin;
    im.Image newImage = im.Image(
      height: newHeight,
      width: newWidth,
    );

    for (int x = 0; x < newImage.width; x++) {
      for (int y = 0; y < newImage.height; y++) {
        newImage.setPixel(x, y, im.ColorFloat16.rgb(255, 255, 255));
      }
    }

    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        im.Pixel pixel = image.getPixel(x, y);
        newImage.setPixel(x + horizontalMargin, y + verticalMargin, pixel);
      }
    }

    Uint8List pngBytes = im.encodePng(newImage);
    return pngBytes;
  }

  Future<Uint8List> svgToPng(
      String svgString, double svgWidth, double svgHeight) async {
    int verticalMargin = 40;
    int horizontalMargin = 40;
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "key");

    final picture = svgDrawableRoot.toPicture(
        size: Size(svgWidth.toDouble(), svgHeight.toDouble()),
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.color));

    final image = await picture.toImage(svgWidth.toInt(), svgHeight.toInt());

    ByteData? bytes = await image.toByteData(format: ImageByteFormat.png);

    return addMarginsToPngFile(
        bytes!.buffer.asUint8List(), verticalMargin, horizontalMargin);
  }

  Future<File> saveFile(String type, String svgString) async {
    final directory = await getExternalStorageDirectory();
    String path = directory!.path;
    String filename = bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase() +
        DateTime.now().toString();
    savedFilePath = '$path/$filename.$type';
    File? file;
    final pdf = pw.Document();

    switch (type) {
      case 'png':
        Uint8List imageInUnit8List = await svgToPng(svgString, height, width);
        file = await File(savedFilePath).create();
        file.writeAsBytesSync(imageInUnit8List);
        await ImageGallerySaver.saveImage(imageInUnit8List);
        break;

      case 'svg':
        file = await File(savedFilePath).create();
        file.writeAsStringSync(svgString);
        await ImageGallerySaver.saveFile('$path/$filename.svg');
        break;

      case 'pdf':
        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Center(
            child: pw.SvgImage(svg: svgString),
          ); // Center
        }));
        file = await File(savedFilePath).create();
        await file.writeAsBytes(await pdf.save());
        break;

      default:
        file = await File(savedFilePath).create();
        file.writeAsString('error');
    }

    return file;
  }

  String _buildBarcode(
    Barcode bc,
    String data, {
    double? width,
    double? height,
    double? fontHeight,
  }) {
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 200,
      fontHeight: fontHeight,
    );

    return svg;
  }

  Barcode _barcodetype(String name) {
    Barcode bc;

    switch (name) {
      case 'QR':
        bc = Barcode.qrCode();
        break;
      case 'Aztec':
        bc = Barcode.aztec();
        break;
      case 'Codabar':
        bc = Barcode.codabar();
        break;
      case 'Code 39':
        bc = Barcode.code39();
        break;
      case 'Code 93':
        bc = Barcode.code93();
        break;
      case 'Code128A':
        bc = Barcode.code128();
        break;
      case 'Code128B':
        bc = Barcode.code128();
        break;
      case 'Code128C':
        bc = Barcode.code128();
        break;
      case 'DataMatrix':
        bc = Barcode.dataMatrix();
        break;
      case 'EAN2':
        bc = Barcode.ean2();
        break;
      case 'EAN5':
        bc = Barcode.ean5();
        break;
      case 'EAN8':
        bc = Barcode.ean8();
        break;
      case 'EAN13':
        bc = Barcode.ean13();
        break;
      case 'GS1-128':
        bc = Barcode.gs128();
        break;
      case 'ISBN':
        bc = Barcode.isbn();
        break;
      case 'ITF-14':
        bc = Barcode.itf14();
        break;
      case 'ITF-16':
        bc = Barcode.itf16();
        break;
      case 'UPC-A':
        bc = Barcode.upcA();
        break;
      case 'ITF2of5':
        bc = Barcode.itf();
        break;
      case 'PDF417':
        bc = Barcode.pdf417();
        break;
      case 'UPC-E':
        bc = Barcode.upcE();
        break;
      case 'RM4SCC':
        bc = Barcode.rm4scc();
        break;
      case 'Telepen':
        bc = Barcode.telepen();
        break;
      default:
        bc = Barcode.qrCode();
    }

    return bc;
  }
}
