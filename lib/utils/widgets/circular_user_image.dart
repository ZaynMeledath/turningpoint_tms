import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';

Widget circularUserImage({
  required String imageUrl,
  required double imageSize,
  required String userName,
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
          errorWidget: (context, url, error) {
            return nameLetterAvatar(
              name: userName,
              circleDiameter: imageSize,
            );
          },
        ),
      ),
    ),
  );
}
