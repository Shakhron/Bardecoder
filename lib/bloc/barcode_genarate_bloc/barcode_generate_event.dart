part of 'barcode_generate_bloc.dart';

@immutable
abstract class BarcodeGenerateEvent {}

class InitData extends BarcodeGenerateEvent {}

class BuildBarcode extends BarcodeGenerateEvent {
  final String data;
  final double? width;
  final double? height;
  final double? fontHeight;

  BuildBarcode(this.data, {this.height, this.width, this.fontHeight});
}

class ShareBarcode extends BarcodeGenerateEvent {}

class SaveFile extends BarcodeGenerateEvent {
  final String type;
  final String svgString;

  SaveFile(this.type, this.svgString);
}

class BarcodeSizeChanged extends BarcodeGenerateEvent {
  final int height;
  final int width;
  final int barcodeSize;
  final String formText;

  BarcodeSizeChanged(
      {required this.height,
      required this.width,
      required this.barcodeSize,
      required this.formText});
}

class RadioButtonChahged extends BarcodeGenerateEvent {
  final String filetype;

  RadioButtonChahged(this.filetype);
}

class TypeChanged extends BarcodeGenerateEvent {
  final String type;

  TypeChanged(this.type);
}
