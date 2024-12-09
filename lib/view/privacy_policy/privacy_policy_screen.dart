// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:turningpoint_tms/constants/app_constants.dart';
// import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PrivacyPolicyScreen extends StatefulWidget {
//   const PrivacyPolicyScreen({super.key});

//   @override
//   State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
// }

// class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
//   late final WebViewController webViewController;

//   @override
//   void initState() {
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadFlutterAsset(
//         'assets/html/privacy_policy.html',
//       )
//       ..enableZoom(true)
//       ..setBackgroundColor(AppColors.scaffoldBackgroundColor)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             webViewController
//                 .runJavaScript("document.body.style.zoom = '2.0';");
//           },
//         ),
//       );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar(
//         title: 'Privacy & Policy',
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
// //====================AppBar====================//

//             SizedBox(height: 10.h),

// //====================Illustration====================//
//             Image.asset(
//               'assets/images/privacy_policy_image.png',
//               width: 200.w,
//             ),
//             SizedBox(height: 10.h),

// //====================Title (Privacy & Policy)====================//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/icons/key_lock_icon.png',
//                   width: 20.w,
//                 ),
//                 SizedBox(width: 4.w),
//                 Column(
//                   children: [
//                     SizedBox(height: 6.h),
//                     Text(
//                       'PRIVACY & POLICY',
//                       style: TextStyle(
//                         fontSize: 20.w,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 10.h),

// //====================Privacy and Policy====================//
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: WebViewWidget(
//                   controller: webViewController,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
