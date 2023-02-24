import 'package:bardecoder/bloc/barcode_genarate_bloc/barcode_generate_bloc.dart';
import 'package:bardecoder/data/models/barcode.dart';
import 'package:bardecoder/data/repositories/barcodes_repository.dart';
import 'package:bardecoder/ui/barcode_generate_widget.dart';
import 'package:bardecoder/ui/barcode_scanning_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BarcodesListWidget extends StatefulWidget {
  const BarcodesListWidget({super.key});
  @override
  State<BarcodesListWidget> createState() => _BarcodesListWidgetState();
}

class _BarcodesListWidgetState extends State<BarcodesListWidget> {
  BarcodesRepository barcodes = BarcodesRepository();
  @override
  void initState() {
    barcodes.initHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 8, 113),
      extendBodyBehindAppBar: true,
      appBar: appbar(),
      body: barcodeList(),
      floatingActionButton: floatingButton(),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget barcodeList() {
    return ListView(
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, top: 48, bottom: 16),
          child: Text(
            'Bardecoder',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27), topRight: Radius.circular(27)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GFTypography(
                    text: 'Избранные',
                    type: GFTypographyType.typo2,
                  ),
                ),
                const HorisontalFavoritListWidget(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GFTypography(
                    text: 'Другие',
                    type: GFTypographyType.typo2,
                  ),
                ),
                GridView.builder(
                    itemCount: allType.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 130.0,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      var list = BarcodesRepository.box!.values.toList();
                      BarcodesRepository.box!.listenable().addListener(() {
                        setState(() {});
                      });

                      return CustomButtonWidget(
                        id: list[index].id,
                        name: list[index].name,
                        imagePath: list[index].imagePath,
                        isFavorit: list[index].isFavorit,
                      );
                    })
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget floatingButton() {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 52, 8, 113),
      onPressed: () async {
        try {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.BARCODE);
          barcodeScanRes == '-1'
              ? null
              // ignore: use_build_context_synchronously
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BarcodeScanningWidget(
                            content: barcodeScanRes,
                          )),
                );
        } on PlatformException {
          String barcodeScanRes = 'Failed to get platform version.';
        }
      },
      child: const Icon(
        Icons.camera_alt,
        size: 30,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButtonWidget extends StatefulWidget {
  bool isFavorit;
  final int id;
  final String name;
  final String imagePath;
  CustomButtonWidget(
      {super.key,
      required this.id,
      required this.isFavorit,
      required this.imagePath,
      required this.name});

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SizedBox(
        child: GFButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => BarcodeGenerateBloc(widget.name),
                        child: BarcodeGenerateWidget(),
                      )),
            );
          },
          color: Colors.transparent,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.fill,
                      height: 47,
                      width: 50,
                    ),
                  ),
                  Positioned(
                    left: 32,
                    top: -10,
                    child: IconButton(
                        enableFeedback: false,
                        splashRadius: 1,
                        iconSize: 20,
                        onPressed: () {
                          widget.isFavorit = !widget.isFavorit;
                          BarcodesRepository().addToFavorit(widget.id);
                          setState(() {});
                        },
                        icon: widget.isFavorit
                            ? const Icon(
                                Icons.star,
                                color: Colors.orange,
                              )
                            : const Icon(Icons.star_border_outlined)),
                  )
                ],
              ),
              Text(widget.name),
            ],
          ),
        ),
      ),
    );
  }
}

class HorisontalFavoritListWidget extends StatelessWidget {
  const HorisontalFavoritListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(77, 78, 124, 194),
              borderRadius: BorderRadius.circular(12)),
          height: 100,
          child: ValueListenableBuilder(
              valueListenable: BarcodesRepository.box!.listenable(),
              builder: (context, Box<Barcode> box, _) {
                List<Barcode> res =
                    box.values.where((element) => element.isFavorit).toList();
                if (res.isEmpty) {
                  return const Center(
                    child: Text('Список пуст!'),
                  );
                }
                return ListView.builder(
                    itemCount: res.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return CustomButtonWidget(
                          id: res[index].id,
                          isFavorit: res[index].isFavorit,
                          imagePath: res[index].imagePath,
                          name: res[index].name);
                    }));
              }),
        ),
      ),
    );
  }
}
