import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/models/static_pages_model/static_pages_model.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';

// final baseUrl = WebUri("https://uae.gosportme.com/pages/size-guide-old");
final baseUrl = WebUri("http://localhost/");

class StaticPagesScreen extends ConsumerWidget {
  final StaticPagesModel singlePage;
  const StaticPagesScreen({super.key, required this.singlePage});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var html = """
<html lang="${AppConstant.selectedLanguage!.toLowerCase()}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Styled Table</title>
  <style> </style>
</head>
<body>
${singlePage.content}
</body>
</html>

""";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          singlePage.title,
          style: AppTextStyles.body2,
        ),
      ),
      body: Center(
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            useShouldOverrideUrlLoading: true,
            allowUniversalAccessFromFileURLs: true,
            standardFontFamily: "CenturyGothic",
            serifFontFamily: "CenturyGothic",
            fixedFontFamily: "CenturyGothic",
            cursiveFontFamily: "CenturyGothic",
            fantasyFontFamily: "CenturyGothic",
            sansSerifFontFamily: "CenturyGothic",
          ),
          // initialUrlRequest: URLRequest(mainDocumentURL: WebUri("https://google.com")),
          initialData: InAppWebViewInitialData(
            data: html,
            baseUrl: baseUrl,
          ),
        ),
      ),
    );
  }
}
