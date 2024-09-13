import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.imageUrl, required this.fit, required this.scale});
  final String imageUrl;
  final BoxFit fit;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl, fit: fit,
      scale: scale,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
        if(loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
        return Icon(Icons.error, color: Colors.red,);
      },
    );
  }
}