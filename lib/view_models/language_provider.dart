import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/languages/arabic_language.dart';
import 'package:golden_doctor/languages/english_language.dart';
// import 'package:golden_doctor/languages/hindi_language.dart';
// import 'package:golden_doctor/languages/italian_language.dart';
// import 'package:golden_doctor/languages/urdu_language.dart';
import 'package:golden_doctor/resources/services/shearedpreference_service.dart';
import 'package:golden_doctor/utils/app_constant.dart';
// import 'package:golden_doctor/views/splash_screen.dart';

// Define the supported languages
enum Language { english, arabic, italian, hindi, urdu }

// Create a provider for managing the selected language
final languageProvider = StateProvider<Language>((ref) => Language.english);

// Function to get the localized text based on the selected language

extension Trans on String {
  String get tr {
    AppConstant.selectedLanguage = ShearedprefService.getLanguage();
    // add  gloable language selected variable in place of this static language value.
    if(AppConstant.selectedLanguage! == "EN"){
      // if (kDebugMode) {
      //   print("did not open file");
      // }
      return this;
    }
    var translation = getLanguageTextfn(
      AppConstant.selectedLanguage!,
      // AppConstant.selectedLanguage == 'EN' ? Language.english : Language.arabic,
    );
    return translation[this] ?? this;
  }
}

Map<String, String> getLanguageTextfn(String language) {
  if (kDebugMode) {
    print("opend a file");
  }
  switch (language) {
    case "AR":
      return arabic;
    default:
      return english;
  }
}
