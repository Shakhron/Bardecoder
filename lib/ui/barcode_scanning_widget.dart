import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarcodeScanningWidget extends StatefulWidget {
  final content;
  const BarcodeScanningWidget({super.key, required this.content});

  @override
  State<BarcodeScanningWidget> createState() => _BarcodeScanningWidgetState();
}

class _BarcodeScanningWidgetState extends State<BarcodeScanningWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SelectableText(widget.content),
            const SizedBox(height: 5),
            IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: widget.content));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Copy'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                    width: 70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ));
                },
                icon: const Icon(Icons.copy))
          ],
        ));
  }
}
