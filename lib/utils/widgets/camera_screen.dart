import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/my_camera_controller.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  CameraController? cameraController;
  late final TabController tabController;
  final myCameraController = MyCameraController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(
      length: 2,
      vsync: this,
    );

    initCamera();

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null ||
        cameraController?.value.isInitialized != true) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.dispose();
    myCameraController.dispose();
  }

  void initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

      cameraController?.addListener(() {
        if (cameraController?.value.isRecordingVideo == true) {
          myCameraController.isRecordingVideoObs.value = true;
        } else {
          myCameraController.isRecordingVideoObs.value = false;
        }
      });
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
          SizedBox(
            width: double.maxFinite,
            height: 650.h,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (cameraController!.value.isRecordingVideo) {
                  return;
                }
                if (details.delta.dx > 0) {
                  // Drag from right to left
                  myCameraController.cameraTabIndexObs.value = 0;
                } else if (details.delta.dx < 0) {
                  // Drag from left to right
                  myCameraController.cameraTabIndexObs.value = 1;
                }
              },
              child: CameraPreview(
                cameraController!,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // cameraController!.value.isRecordingVideo
          //     ? SizedBox()
          //     :
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    myCameraController.cameraTabIndexObs.value = 0;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 3.w,
                    ),
                    child: Text(
                      'Photo',
                      style: TextStyle(
                        color: myCameraController.cameraTabIndexObs.value == 0
                            ? Colors.yellow
                            : Colors.white,
                        fontWeight:
                            myCameraController.cameraTabIndexObs.value == 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25.w),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    myCameraController.cameraTabIndexObs.value = 1;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 3.w,
                    ),
                    child: Text(
                      'Video',
                      style: TextStyle(
                        color: myCameraController.cameraTabIndexObs.value == 1
                            ? Colors.yellow
                            : Colors.white,
                        fontWeight:
                            myCameraController.cameraTabIndexObs.value == 1
                                ? FontWeight.w600
                                : FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              if (myCameraController.cameraTabIndexObs.value == 0) {
                cameraController!.takePicture();
              } else {
                myCameraController.recordVideo(
                    cameraController: cameraController!);
              }
            },
            child: Stack(
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
                Obx(
                  () {
                    final containerSize =
                        myCameraController.isRecordingVideoObs.value
                            ? 25.w
                            : 45.w;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: containerSize,
                      height: containerSize,
                      decoration: BoxDecoration(
                        // shape: myCameraController.isRecordingVideoObs.value
                        //     ? BoxShape.rectangle
                        //     : BoxShape.circle,
                        borderRadius:
                            myCameraController.isRecordingVideoObs.value
                                ? BorderRadius.circular(4)
                                : BorderRadius.circular(100),
                        color: myCameraController.cameraTabIndexObs.value == 0
                            ? Colors.white
                            : Colors.red,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
