import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  CameraController? cameraController;
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    initCamera();
    super.initState();
  }

  void initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController?.value.isInitialized != true) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: myAppBar(title: 'Camera'),
      body: Column(
        // alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4.5,
            child: CameraPreview(
              cameraController!,
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 160.w,
            child: TabBar(
              controller: tabController,
              dividerColor: Colors.transparent,
              tabs: [
                Text(
                  'Photo',
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  'Video',
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4.w,
                  ),
                ),
              ),
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          // SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
