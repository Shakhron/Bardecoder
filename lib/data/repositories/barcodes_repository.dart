import 'package:bardecoder/data/models/barcode.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BarcodesRepository {
  static Box<Barcode>? box;

  initHive() async {
    box = Hive.box<Barcode>('barcodes');
    if (Hive.box<Barcode>('barcodes').isEmpty) {
      for (var element in allType) {
        box!.add(element);
      }
    }
  }

  addToFavorit(int index) {
    Barcode old = box!.values.elementAt(index);
    old.isFavorit = !old.isFavorit;
    box!.putAt(index, old);
  }

  getRecentUsed() {}
}

List<Barcode> allType = [
  Barcode(
    imagePath: 'images/qr.png',
    name: 'QR',
    isFavorit: false,
    id: 0,
    //minlenghth = int
    //maxlenghth = int
    //datatype ="string" or "int"
  ),
  Barcode(
    imagePath: 'images/Aztec.png',
    name: 'Aztec',
    isFavorit: false,
    id: 1,
  ),
  Barcode(
    imagePath: 'images/Codabar.png',
    name: 'Codabar',
    isFavorit: false,
    id: 2,
  ),
  Barcode(
    imagePath: 'images/code39.png',
    name: 'Code 39',
    isFavorit: false,
    id: 3,
  ),
  Barcode(
    imagePath: 'images/code93.png',
    name: 'Code 93',
    isFavorit: false,
    id: 4,
  ),
  Barcode(
    imagePath: 'images/code128A.png',
    name: 'Code128A',
    isFavorit: false,
    id: 5,
  ),
  Barcode(
    imagePath: 'images/code128B.png',
    name: 'Code128B',
    isFavorit: false,
    id: 6,
  ),
  Barcode(
    imagePath: 'images/code128C.png',
    name: 'Code128C',
    isFavorit: false,
    id: 7,
  ),
  Barcode(
    imagePath: 'images/DataMatrix.png',
    name: 'DataMatrix',
    isFavorit: false,
    id: 8,
  ),
  Barcode(
    imagePath: 'images/EAN2.png',
    name: 'EAN2',
    isFavorit: false,
    id: 9,
  ),
  Barcode(
    imagePath: 'images/EAN5.png',
    name: 'EAN5',
    isFavorit: false,
    id: 10,
  ),
  Barcode(
    imagePath: 'images/EAN8.png',
    name: 'EAN8',
    isFavorit: false,
    id: 11,
  ),
  Barcode(
    imagePath: 'images/EAN13.png',
    name: 'EAN13',
    isFavorit: false,
    id: 12,
  ),
  Barcode(
    imagePath: 'images/GS1-128.png',
    name: 'GS1-128',
    isFavorit: false,
    id: 13,
  ),
  Barcode(
    imagePath: 'images/ISBN.png',
    name: 'ISBN',
    isFavorit: false,
    id: 14,
  ),
  Barcode(
    imagePath: 'images/ITF-14.png',
    name: 'ITF-14',
    isFavorit: false,
    id: 15,
  ),
  Barcode(
    imagePath: 'images/ITF-16.png',
    name: 'ITF-16',
    isFavorit: false,
    id: 16,
  ),
  Barcode(
    imagePath: 'images/UPC-A.png',
    name: 'UPC-A',
    isFavorit: false,
    id: 17,
  ),
  // Barcode(
  //   imagePath: 'images/ITF2of5.png',
  //   name: 'ITF2of5',
  //   isFavorit: false,
  //   id: 18,
  // ),
  Barcode(
    imagePath: 'images/PDF417.png',
    name: 'PDF417',
    isFavorit: false,
    id: 19,
  ),
  // Barcode(
  //   imagePath: 'images/UPC-E.png',
  //   name: 'UPC-E',
  //   isFavorit: false,
  //   id: 20,
  // ),
  Barcode(
    imagePath: 'images/RM4SCC.png',
    name: 'RM4SCC',
    isFavorit: false,
    id: 21,
  ),
  Barcode(
    imagePath: 'images/Telepen.png',
    name: 'Telepen',
    isFavorit: false,
    id: 22,
  ),
];
