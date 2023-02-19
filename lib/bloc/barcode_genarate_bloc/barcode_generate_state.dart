part of 'barcode_generate_bloc.dart';

@immutable
abstract class BarcodeGenerateState {}

class BarcodeGenerateInitial extends BarcodeGenerateState {}

class BarcodeBuildedSuccessful extends BarcodeGenerateState {
  final String svg;

  BarcodeBuildedSuccessful(this.svg);
}

class BarcodeBuildedFailure extends BarcodeGenerateState {
  final String error;

  BarcodeBuildedFailure(this.error);
}

class RadioButtonChangedState extends BarcodeGenerateState {}

class BarcodeSizeChangedState extends BarcodeGenerateState {}

class BarcodeTypeChangedState extends BarcodeGenerateState {}
