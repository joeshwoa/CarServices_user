import 'dart:async';
import 'dart:io';

import 'package:autoflex/controllers/home/payment_controller.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

class WebViewScreen extends StatefulWidget {
  final url;
  const WebViewScreen({super.key, @required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String _url = '';
  String _code = '';
  bool _showLoader = false;
  bool _showedOnce = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _url = widget.url;
    // print('url in webview $_url, $_code');
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          title: Text(
            "PAYMENT".tr,
            style: const TextStyle(
              color: ConstantColors.primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.17,
            ),
          ),
          leading: IconButton(
              icon: Get.locale?.languageCode == 'en'
                  ? SvgPicture.asset(arrowBack)
                  : Transform.rotate(
                      angle: 3.14,
                      child: SvgPicture.asset(arrowBack),
                    ),
              onPressed: () {
                Get.back();
              }),
        ),
        body: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            // print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            // print('Page started loading: $url');
            _showedOnce = false;
            if (url.contains('close')) {
              // print('call the api');
            }
            if (url.contains('abort')) {
              // print('show fail and pop');
            }
          },
          onPageFinished: (String url) {
            // print('Page finished loading: $url');
            if (url.contains('success')) {
              // print('call the api');
              Get.back(result: 'success');
              paymentController.loading.value = true;
            }
          },
          gestureNavigationEnabled: true,
        ));
  }
}
