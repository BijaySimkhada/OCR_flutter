import 'package:flutter/material.dart';

class ImageNotFoundException extends StatelessWidget {
  final String message;
  const ImageNotFoundException(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$message'),
    );
  }
}
