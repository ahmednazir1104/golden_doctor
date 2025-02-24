import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:golden_doctor/utils/app_colors.dart';

class WebViewCheckout extends StatefulWidget {
  final String weburl;

  const WebViewCheckout({super.key, required this.weburl});

  @override
  State<WebViewCheckout> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<WebViewCheckout> {
  bool isLoading = true;
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.weburl)),
            initialSettings: InAppWebViewSettings(
              useHybridComposition: true,
            ),
            // headlessWebView: HeadlessInAppWebView(
            //   initialUrlRequest: URLRequest(url: WebUri(widget.weburl)),
            // ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) async {
              // await controller.evaluateJavascript(source: """
              //   document.querySelector('header').style.display = 'none';
              // """);
              //  await controller.evaluateJavascript(source: """
              //   var style = document.createElement('style');
              //   style.innerHTML = 'header { display: none !important; }';
              //   document.head.appendChild(style);
              // """);
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.myScaffold,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
