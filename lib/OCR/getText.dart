import 'package:google_ml_kit/google_ml_kit.dart';

Future<List<RecognizedText>> getText(String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  final textDetector = GoogleMlKit.vision.textRecognizer();
  final RecognizedText recognizedText =
      await textDetector.processImage(inputImage);

  List<RecognizedText> recognizedList = [];

  for (TextBlock block in recognizedText.blocks) {
    // print(block.text != null? block.text.toString():'');
    recognizedList.add(RecognizedText(
        text: block.text as String,
        blocks:[]));
  }

  return recognizedList;
}
