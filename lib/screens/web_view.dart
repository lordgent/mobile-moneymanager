import 'package:flutter/material.dart';
import 'package:moneymanager/widgets/transaction_detail.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  late String url;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (routeArguments != null) {
      url = routeArguments;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionDetail(),
        ),
      );
    }

    controller.loadRequest(Uri.parse(url));

    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) {
        controller.runJavaScript("""
          var metaTag = document.createElement('meta');
          metaTag.name = 'viewport';
          metaTag.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
          document.getElementsByTagName('head')[0].appendChild(metaTag);
        """);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionDetail(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
