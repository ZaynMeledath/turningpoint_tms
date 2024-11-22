import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget circularUserImage({
  required String imageUrl,
  required double imageSize,
  BoxBorder? border,
}) {
  return Container(
    width: imageSize,
    height: imageSize,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: border,
    ),
    child: Center(
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: imageSize,
          height: imageSize,
        ),
      ),
    ),
  );
}
