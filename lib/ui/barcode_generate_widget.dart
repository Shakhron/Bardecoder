import 'package:bardecoder/bloc/barcode_genarate_bloc/barcode_generate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BarcodeGenerateWidget extends StatelessWidget {
  BarcodeGenerateWidget({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BarcodeGenerateBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 52, 8, 113),
        actions: [
          IconButton(
            onPressed: () {
              bloc.add(ShareBarcode());
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
            bloc.saveFile(bloc.fileType, bloc.barcodeImage);
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

  Widget customRadioButton(String text) {
    return BlocBuilder<BarcodeGenerateBloc, BarcodeGenerateState>(
      buildWhen: (previous, current) {
        if (current is BarcodeGenerateInitial ||
            current is BarcodeTypeChangedState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return OutlinedButton(
          onPressed: () {
            context.read<BarcodeGenerateBloc>().add(TypeChanged(text));
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(
              width: 3,
              color: (context.read<BarcodeGenerateBloc>().fileType == text)
                  ? const Color.fromARGB(255, 106, 0, 255)
                  : Colors.grey,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: (context.read<BarcodeGenerateBloc>().fileType == text)
                  ? const Color.fromARGB(255, 52, 8, 113)
                  : Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget sizeRadioButton() {
    return BlocBuilder<BarcodeGenerateBloc, BarcodeGenerateState>(
      buildWhen: (previous, current) {
        if (current is BarcodeSizeChangedState || controller.text.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Выберите размер файла',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              value: 1,
              groupValue: context.read<BarcodeGenerateBloc>().barcodeSize,
              onChanged: controller.text.isEmpty
                  ? null
                  : (value) {
                      context.read<BarcodeGenerateBloc>().add(
                          BarcodeSizeChanged(
                              height: 50,
                              width: 50,
                              barcodeSize: int.parse(value!.toString()),
                              formText: controller.text));
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
              groupValue: context.read<BarcodeGenerateBloc>().barcodeSize,
              onChanged: controller.text.isEmpty
                  ? null
                  : (value) {
                      context.read<BarcodeGenerateBloc>().add(
                          BarcodeSizeChanged(
                              height: 80,
                              width: 80,
                              barcodeSize: int.parse(value!.toString()),
                              formText: controller.text));
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
              groupValue: context.read<BarcodeGenerateBloc>().barcodeSize,
              onChanged: controller.text.isEmpty
                  ? null
                  : (value) {
                      context.read<BarcodeGenerateBloc>().add(
                          BarcodeSizeChanged(
                              height: 110,
                              width: 110,
                              barcodeSize: int.parse(value!.toString()),
                              formText: controller.text));
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
              groupValue: context.read<BarcodeGenerateBloc>().barcodeSize,
              onChanged: controller.text.isEmpty
                  ? null
                  : (value) {
                      context.read<BarcodeGenerateBloc>().add(
                          BarcodeSizeChanged(
                              height: 170,
                              width: 170,
                              barcodeSize: int.parse(value!.toString()),
                              formText: controller.text));
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
              groupValue: context.read<BarcodeGenerateBloc>().barcodeSize,
              onChanged: controller.text.isEmpty
                  ? null
                  : (value) {
                      context.read<BarcodeGenerateBloc>().add(
                          BarcodeSizeChanged(
                              height: 230,
                              width: 230,
                              barcodeSize: int.parse(value!.toString()),
                              formText: controller.text));
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
              groupValue: context.read<BarcodeGenerateBloc>().barcodeSize,
              onChanged: controller.text.isEmpty
                  ? null
                  : (value) {
                      context.read<BarcodeGenerateBloc>().add(
                          BarcodeSizeChanged(
                              height: 280,
                              width: 280,
                              barcodeSize: int.parse(value!.toString()),
                              formText: controller.text));
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
      },
    );
  }

  Widget generatedBarcode() {
    return BlocBuilder<BarcodeGenerateBloc, BarcodeGenerateState>(
      buildWhen: (previous, current) {
        if (current is BarcodeBuildedSuccessful ||
            current is BarcodeBuildedFailure ||
            current is BarcodeSizeChangedState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text(
              context.read<BarcodeGenerateBloc>().bc.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 16),
            SvgPicture.string(context.read<BarcodeGenerateBloc>().barcodeImage),
            const SizedBox(height: 16),
            (state is BarcodeBuildedFailure)
                ? Text(state.error, style: const TextStyle(color: Colors.red))
                : const Text(''),
          ],
        );
      },
    );
  }

  Widget form() {
    return BlocBuilder<BarcodeGenerateBloc, BarcodeGenerateState>(
      builder: (context, state) {
        return Form(
            onChanged: () {
              context
                  .read<BarcodeGenerateBloc>()
                  .add(BuildBarcode(controller.text));
            },
            child: TextFormField(
              maxLines: 10,
              minLines: 1,
              controller: controller,
              maxLength: context.read<BarcodeGenerateBloc>().bc.maxLength,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ));
      },
    );
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
            customRadioButton('svg'),
            customRadioButton('png'),
            customRadioButton('pdf'),
          ],
        ),
      ],
    );
  }
}
