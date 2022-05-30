import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:test_ocr/Model/Image.model.dart';
import 'package:test_ocr/OCR/getText.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({Key? key}) : super(key: key);

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  ImageModel? img;
  MediaService media = MediaService();
  String _path = '';
  List<String> block_text = [];

  _getImageFromGallery() async {
    img = await media.pickImageFromGallery();
    setState(() {
      _path = img?.imagePath as String;
    });
    List<RecognizedText> text = await getText(_path);
    setState(() {
      for (var t in text) {
        block_text.add(t.text.toString());
      }
    });
  }

  _getImageFromCamera() async {
    img = await media.pickImageFromCamera();
    setState(() {
      _path = img?.imagePath as String;
    });
    List<RecognizedText> text = await getText(_path);
    setState(() {
      for (var t in text) {
        block_text.add(t.text.toString());
        print(t.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OCR Testing'),
        actions: const [Icon(Icons.person)],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 60,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'OCR Testing',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: _getImageFromCamera,
                    icon: const Icon(Icons.camera)),
                IconButton(
                  onPressed: _getImageFromGallery,
                  icon: const Icon(Icons.browse_gallery_outlined),
                )
              ],
            ),
            _path != ''
                ? Image.file(
                    File(_path),
                    height: 200,
                    width: 300,
                  )
                : const Text('No Image Selected'),
            Wrap(
              children: List<Text>.generate(
                  block_text.length, (index) => Text(block_text[index])),
            ),
          ],
        ),
      ),
    );
  }
}
