import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_extend/share_extend.dart';
import 'package:xml/xml.dart';

class BarcodeGenerateWidget extends StatefulWidget {
  final String name;
  const BarcodeGenerateWidget({super.key, required this.name});

  @override
  State<BarcodeGenerateWidget> createState() => _BarcodeGenerateWidgetState();
}

class _BarcodeGenerateWidgetState extends State<BarcodeGenerateWidget> {
  String barcodeImage = '';
  Barcode bc = Barcode.qrCode();
  bool error = false;
  String srterror = '';
  String fileType = 'png';
  double height = 110;
  double width = 110;
  int barcodeSize = 3;
  String savedFilePath = '';

  @override
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    bc = barcodetype(widget.name);
    barcodeImage = buildBarcode(bc, '0' * bc.minLength);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 52, 8, 113),
        actions: [
          IconButton(
            onPressed: () {
              share();
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          generatedBarcode(),
          const SizedBox(height: 16),
          form(),
          const SizedBox(height: 24),
          sizeRadioButton(),
          const SizedBox(height: 24),
          fileTypeRadio(),
          const SizedBox(height: 120)
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            saveFile(fileType, barcodeImage);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(201, 52, 8, 113),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Сохранить файл',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget CustomRadioButton(String text) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          fileType = text;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(
            width: 3,
            color: (fileType == text)
                ? const Color.fromARGB(255, 106, 0, 255)
                : Colors.grey),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: (fileType == text)
              ? const Color.fromARGB(255, 52, 8, 113)
              : Colors.grey,
        ),
      ),
    );
  }

  Widget sizeRadioButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Выберите размер файла',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        RadioListTile(
          value: 1,
          groupValue: barcodeSize,
          onChanged: controller.text.isEmpty
              ? null
              : (value) {
                  setState(() {
                    barcodeSize = int.parse(value!.toString());
                    height = 50;
                    width = 50;
                    error
                        ? buildBarcode(bc, '0' * bc.minLength,
                            height: height, width: width)
                        : barcodeImage = buildBarcode(bc, controller.text,
                            height: height, width: width);
                  });
                },
          title: Row(children: const [
            Text('1'),
            SizedBox(width: 5),
            Text(
              '(50x50)',
              style: TextStyle(color: Colors.grey),
            )
          ]),
        ),
        RadioListTile(
          value: 2,
          groupValue: barcodeSize,
          onChanged: controller.text.isEmpty
              ? null
              : (value) {
                  setState(() {
                    barcodeSize = int.parse(value!.toString());
                    height = 80;
                    width = 80;
                    error
                        ? buildBarcode(bc, '0' * bc.minLength,
                            height: height, width: width)
                        : barcodeImage = buildBarcode(bc, controller.text,
                            height: height, width: width);
                  });
                },
          title: Row(children: const [
            Text('2'),
            SizedBox(width: 5),
            Text(
              '(80x80)',
              style: TextStyle(color: Colors.grey),
            )
          ]),
        ),
        RadioListTile(
          value: 3,
          groupValue: barcodeSize,
          onChanged: controller.text.isEmpty
              ? null
              : (value) {
                  setState(() {
                    barcodeSize = int.parse(value!.toString());
                    height = 110;
                    width = 110;
                    error
                        ? buildBarcode(bc, '0' * bc.minLength,
                            height: height, width: width)
                        : barcodeImage = buildBarcode(bc, controller.text,
                            height: height, width: width);
                  });
                },
          title: Row(children: const [
            Text('3'),
            SizedBox(width: 5),
            Text(
              '(110x110)',
              style: TextStyle(color: Colors.grey),
            )
          ]),
        ),
        RadioListTile(
          value: 4,
          groupValue: barcodeSize,
          onChanged: controller.text.isEmpty
              ? null
              : (value) {
                  setState(() {
                    barcodeSize = int.parse(value!.toString());
                    height = 170;
                    width = 170;
                    error
                        ? buildBarcode(bc, '0' * bc.minLength,
                            height: height, width: width)
                        : barcodeImage = buildBarcode(bc, controller.text,
                            height: height, width: width);
                  });
                },
          title: Row(children: const [
            Text('4'),
            SizedBox(width: 5),
            Text(
              '(170x170)',
              style: TextStyle(color: Colors.grey),
            )
          ]),
        ),
        RadioListTile(
          value: 5,
          groupValue: barcodeSize,
          onChanged: controller.text.isEmpty
              ? null
              : (value) {
                  setState(() {
                    barcodeSize = int.parse(value!.toString());
                    height = 230;
                    width = 230;
                    error
                        ? buildBarcode(bc, '0' * bc.minLength,
                            height: height, width: width)
                        : barcodeImage = buildBarcode(bc, controller.text,
                            height: height, width: width);
                  });
                },
          title: Row(children: const [
            Text('5'),
            SizedBox(width: 5),
            Text(
              '(230x230)',
              style: TextStyle(color: Colors.grey),
            )
          ]),
        ),
        RadioListTile(
          value: 6,
          groupValue: barcodeSize,
          onChanged: controller.text.isEmpty
              ? null
              : (value) {
                  setState(() {
                    barcodeSize = int.parse(value!.toString());
                    height = 280;
                    width = 280;
                    error
                        ? buildBarcode(bc, '0' * bc.minLength,
                            height: height, width: width)
                        : barcodeImage = buildBarcode(bc, controller.text,
                            height: height, width: width);
                  });
                },
          title: Row(children: const [
            Text('6'),
            SizedBox(width: 5),
            Text(
              '(280x280)',
              style: TextStyle(color: Colors.grey),
            )
          ]),
        ),
      ],
    );
  }

  Widget generatedBarcode() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Text(
          bc.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )),
        const SizedBox(height: 16),
        error
            ? SvgPicture.string(buildBarcode(bc, '0' * bc.minLength,
                height: height, width: width))
            : SvgPicture.string(barcodeImage),
        const SizedBox(height: 16),
        error
            ? Text(
                srterror,
                style: const TextStyle(color: Colors.red),
              )
            : Text(''),
      ],
    );
  }

  Widget form() {
    return Form(
        onChanged: () {
          try {
            error = false;
            barcodeImage =
                buildBarcode(bc, controller.text, height: height, width: width);
            setState(() {});
          } catch (e) {
            srterror = e.toString();
            error = true;
            setState(() {});
          }
        },
        child: TextFormField(
          maxLines: 10,
          minLines: 1,
          controller: controller,
          maxLength: bc.maxLength,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)),
          ),
        ));
  }

  Widget fileTypeRadio() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Выберите формат файла',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRadioButton('svg'),
            CustomRadioButton('png'),
            CustomRadioButton('pdf'),
          ],
        ),
      ],
    );
  }

  String buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
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

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory!.path;
  }

  Future<File> saveFile(String type, String svgString) async {
    String path = await _localPath;
    String filename = bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase() +
        DateTime.now().toString();
    savedFilePath = '$path/$filename.$type';
    File? file;
    final pdf = pw.Document();
    switch (type) {
      case 'png':
        Uint8List imageInUnit8List =
            await svgToPng(context, svgString, height.toInt(), width.toInt());
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

  // Future<void> convertSvgToPng(String svgContent, String pngFilePath,
  //     {double leftMargin = 0,
  //     double rightMargin = 0,
  //     double topMargin = 0,
  //     double bottomMargin = 0}) async {
  //   final svg = SvgParser().parseSvg(svgContent);

  //   final pictureRecorder = PictureRecorder();
  //   final canvas = Canvas(pictureRecorder);
  //   final rect =
  //       svg.rect.inflate(-leftMargin, -topMargin, -rightMargin, -bottomMargin);
  //   svg.paint(canvas, rect);
  //   final picture = pictureRecorder.endRecording();

  //   final pngBytes = await picture
  //       .toImage(
  //         rect.width.toInt(),
  //         rect.height.toInt(),
  //       )
  //       .toByteData(format: ImageByteFormat.png);

  //   File(pngFilePath).writeAsBytesSync(pngBytes.buffer.asUint8List());
  // }

  Future<Uint8List> svgToPng(BuildContext context, String svgString,
      int svgWidth, int svgHeight) async {
    print(svgString);
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "key");
    XmlDocument document = XmlDocument.parse(svgString);
    final svgWidth = width.toDouble();
    final svgHeight = height.toDouble();
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    double widthimage = svgHeight * devicePixelRatio;
    double heightimage = svgWidth * devicePixelRatio;

    final picture = svgDrawableRoot.toPicture(
        size: Size(widthimage, heightimage),
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.color));

    final image =
        await picture.toImage(widthimage.toInt(), heightimage.toInt());

    ByteData? bytes = await image.toByteData(format: ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
  }

  void share() async {
    File file = await saveFile(fileType, barcodeImage);
    if (!await file.exists()) {
      await file.create(recursive: true);
      file.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(file.path, "file");
  }
}

Barcode barcodetype(String name) {
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
