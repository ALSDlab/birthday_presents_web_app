//
// import 'dart:collection';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// class AmazonWebviewPage extends StatefulWidget {
//   const AmazonWebviewPage({
//     super.key,
//     required this.name,
//     required this.yearCountWithEnding,
//   });
//
//   final String name;
//   final String yearCountWithEnding;
//
//   @override
//   _AmazonWebviewPageState createState() => _AmazonWebviewPageState();
// }
//
// class _AmazonWebviewPageState extends State<AmazonWebviewPage> {
//   final GlobalKey webViewKey = GlobalKey();
//
//   InAppWebViewController? webViewController;
//
//   InAppWebViewSettings settings = InAppWebViewSettings(
//     isInspectable: kDebugMode,
//     mediaPlaybackRequiresUserGesture: false,
//     allowsInlineMediaPlayback: true,
//     iframeAllow: "camera; microphone",
//     iframeAllowFullscreen: true,
//     userAgent: 'random'
//   );
//   String url = 'https://google.com';
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter InAppWebView 예시'),
//         ),
//         body: Container(
//           child: InAppWebView(
//             key: webViewKey,
//             initialUrlRequest:
//             URLRequest(url: WebUri('https://www.amazon.com/webhp?igu=1')),
//             // initialUrlRequest:
//             // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
//             // initialFile: "assets/index.html",
//             initialUserScripts: UnmodifiableListView<UserScript>([]),
//             initialSettings: settings,
//             onWebViewCreated: (controller) async {
//               webViewController = controller;
//             },
//
//             onPermissionRequest: (controller, request) async {
//               return PermissionResponse(
//                   resources: request.resources,
//                   action: PermissionResponseAction.GRANT);
//             },
//               shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
//                 var url = 'https://google.com';
//                 var uri = Uri.parse(url);
//
//                 if ((uri.toString()).contains('https://google.com')) {
//                   return NavigationActionPolicy.ALLOW;
//                 } else {
//                   launchUrl(Uri.parse(url));
//                   return NavigationActionPolicy.CANCEL;
//                 }
//               }
//             // onConsoleMessage: (controller, consoleMessage) {
//             //   print(consoleMessage);
//             // },
//           ),
//         ),
//       ),
//     );
//   }
// }
