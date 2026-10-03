import 'package:flutter/material.dart';
import 'package:vlr/services/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/wealth_grow_app/theme/invert_app_theme.dart';

class WebViewScreenInvest extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreenInvest({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<WebViewScreenInvest> createState() =>
      _WebViewScreenInvestState();
}

class _WebViewScreenInvestState
    extends State<WebViewScreenInvest> {
  late final WebViewController _webViewController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(
              'WebView Error: ${error.description}',
            );
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: backgroundDark,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: textPrimary,
          ),
        ),
        title: CustomText(
          widget.title,
          style: Helper(context)
              .textTheme
              .titleLarge
              ?.copyWith(
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}