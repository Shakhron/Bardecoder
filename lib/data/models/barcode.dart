import 'package:hive/hive.dart';

part 'barcode.g.dart';

@HiveType(typeId: 0)
class Barcode {
  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int id;
  @HiveField(3)
  bool isFavorit;
  Barcode(
      {required this.id,
      required this.imagePath,
      required this.isFavorit,
      required this.name});
}
