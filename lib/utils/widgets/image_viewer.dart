import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:turningpoint_tms/utils/download_file.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  const ImageViewer({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Image Viewer',
        trailingIcons: [
          IconButton(
            onPressed: () {
              downloadFile(fileUrl: imageUrl);
            },
            icon: Icon(
              Icons.download,
              size: 24.w,
            ),
          )
        ],
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}
