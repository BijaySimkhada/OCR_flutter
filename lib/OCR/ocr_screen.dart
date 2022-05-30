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
  String _text = '';

  _getImageFromGallery() async {
    setState(() {
      _text = '';
    });
    img = await media.pickImageFromGallery();
    setState(() {
      _path = img?.imagePath as String;
    });
    List<RecognizedText> text = await getText(_path);
    setState(() {
      for (var t in text) {
        block_text.add(t.text.toString());
        _text = _text + t.text.toString();
      }
      // _text = block_text.toString();
    });
  }

  _getImageFromCamera() async {
    setState(() {
      _text = '';
    });
    img = await media.pickImageFromCamera();
    setState(() {
      _path = img?.imagePath as String;
    });
    List<RecognizedText> text = await getText(_path);
    setState(() {
      for (var t in text) {
        block_text.add(t.text.toString());
        _text = _text + t.text.toString();
      }
      // _text = block_text.toString();
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: _getImageFromCamera,
                        icon: const Icon(Icons.camera)),
                    IconButton(
                      onPressed: _getImageFromGallery,
                      icon: const Icon(Icons.image_rounded),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.black54,
                child: _path != ''
                    ? Image.file(
                        File(_path),
                        height: 200,
                        width: 300,
                      )
                    : const Center(child:Text('No Image Selected',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white54
                ),),)
              ),
              const Text('Captured Text:', style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w500,
              ),),
              // Wrap(
              //   children: List<Text>.generate(
              //       block_text.length, (index) => Text(block_text[index])),
              // ),
              // Text(_text),
              _text != '' ? SelectableText(_text, style: const TextStyle(
                fontSize: 18
              ),) : const Text('No Text Found!', style: TextStyle(
                fontSize: 18
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
