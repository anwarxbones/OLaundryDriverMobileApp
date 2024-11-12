import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressHelper {
  // Singleton instance
  static final ImageCompressHelper _instance = ImageCompressHelper._internal();

  factory ImageCompressHelper() => _instance;

  ImageCompressHelper._internal();

  Future<File?> compressedImage(File? image) async {
    try {
      if (image == null) {
        return null;
      }
      if (getSize(image) > 2.0) {
        final String targetPath =
            '${image.path}_compressed.jpg'; // Ensure the compressed file has .jpg extension

        final result = await FlutterImageCompress.compressAndGetFile(
          image.path,
          targetPath,
          quality: 70,
        );

        return result != null ? File(result.path) : image;
      }
      return image;
    } catch (e) {
      debugPrint('Error during image compression: $e');
      return image;
    }
  }

  double getSize(File image) {
    final int sizeInBytes = image.lengthSync();
    final double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}
