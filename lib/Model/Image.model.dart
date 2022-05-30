import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel {
  String? imagePath;
  XFile? img;
  ImageModel({required this.imagePath, required this.img});
}

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();
  ImageModel? image;

  Future<ImageModel> pickImageFromGallery() async {
    print('tap');
    try {
      XFile? _image = await _imagePicker.pickImage(source: ImageSource.gallery);
      final image = ImageModel(imagePath: _image!.path, img: _image);
      return image;
    } catch (e) {
      throw e;
    }
  }

  Future<ImageModel> pickImageFromCamera() async {
    print('Camera tap');
    try {
      XFile? _image = await _imagePicker.pickImage(source: ImageSource.camera);
      final image = ImageModel(imagePath: _image!.path, img: _image);
      return image;
    } catch (e) {
      throw e;
    }
  }



}
