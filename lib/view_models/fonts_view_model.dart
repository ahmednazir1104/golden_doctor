import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_doctor/languages/arabic_language.dart';
import 'package:golden_doctor/languages/english_language.dart';
import 'package:golden_doctor/models/fonts_model.dart';
import 'package:golden_doctor/models/language/language_model.dart';
import 'package:golden_doctor/models/products_colors_model.dart';
import 'package:golden_doctor/models/static_pages_model/static_pages_model.dart';
import 'package:golden_doctor/models/traqnslation_model/translation_model.dart';
import 'package:golden_doctor/utils/app_fonts.dart';

// List<TranslationModel> homePageTranslations = [];
// List<TranslationModel> filtersTranslations = [];
// List<TranslationModel> navigationTranslations = [];
// List<TranslationModel> staticPagesTranslations = [];
// List<TranslationModel> otherTranslations = [];
// List<ColorPalette> colorPallete = [];

//////////////////////////////////////////////////////////////////       Font Seeting  Provider    /////////////////////////////////////////////////////////////////
final fontSettingsProvider = FutureProvider<FontSettings>((ref) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection('settings')
        // .doc('fontSettings')
        .doc('theme')
        .get();
    if (kDebugMode) {
      print('document data ==== ${doc.data()}');
    }
    if (doc.exists && doc.data() != null) {
      // print('data======');
      FontSettings vreb = FontSettings.fromMap(doc.data()!);
      AppTextStyles.updateFontStyles(
        family: vreb.fontFamily,
        // h1Size: double.parse(fontSettings.headline1Size.toString()),
        // h2Size: double.parse(fontSettings.headline2Size.toString()),
        // b1Size: double.parse(fontSettings.body1Size.toString()),
        // b2Size: double.parse(fontSettings.body2Size.toString()),
        // b3Size: double.parse(fontSettings.body3Size.toString()),
        // h1Weight: fontWeightFromInt(fontSettings.headline1Weight),
        // h2Weight: fontWeightFromInt(fontSettings.headline2Weight),
        // b1Weight: fontWeightFromInt(fontSettings.body1Weight),
        // b2Weight: fontWeightFromInt(fontSettings.body2Weight),
        // b3Weight: fontWeightFromInt(fontSettings.body3Weight),
      );

      if (kDebugMode) {
        print('data======');
      }
      return FontSettings.fromMap(
          doc.data()!); // Assumes fromMap is implemented
    } else {
      throw Exception("Document does not exist or has no data");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching font settings: $e');
    }
    rethrow; // This will trigger the error state in your provider
  }
});

//////////////////////////////////////////////////////////////////       Language  Provider    /////////////////////////////////////////////////////////////////
final getLanguageProvider = FutureProvider<List<LanguageModel>>((ref) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection('languages')
        .doc('languages')
        .get();

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      final languages = (data['languages'] as List)
          .map((language) => LanguageModel.fromMap(language))
          .toList();
      return languages;
    } else {
      throw Exception("Document does not exist or has no data");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching languages: $e');
    }
    rethrow;
  }
});

//////////////////////////////////////////////////////////////////       Translation  Provider    /////////////////////////////////////////////////////////////////
final getTranslationProvider = FutureProvider.autoDispose<void>((ref) async {
  log('Fetching Translation ===== 1');
  try {
    final doc = await FirebaseFirestore.instance
        .collection('translations')
        .doc('translations')
        .get();

    // log('document data ==== ${doc.data()}');
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      final translations = (data['translations'] as List)
          .map((translation) => TranslationModel.fromMap(translation))
          .toList();
      log('translations has data === ');
      // Update English and Arabic translations based on locale
      for (var translation in translations) {
        // Update the English map with the dynamic content
        english[translation.baseContent] = translation.baseContent;
        // Update the Arabic map with the dynamic content
        arabic[translation.baseContent] = translation.translatedContent;
        // if (translation.locale == 'EN') {
        //   // Update the English map with the dynamic content
        //   english[translation.baseContent] = translation.baseContent;
        //   // log('Translation added to English: ${translation.baseContent} -> ${translation.translatedContent}');
        //   // log('translations in  EN === ');
        // } else if (translation.locale == 'AR') {
        //   // Update the Arabic map with the dynamic content
        //   arabic[translation.baseContent] = translation.translatedContent;
        //   //  log('Translation added to Arabic: ${translation.baseContent} -> ${translation.translatedContent}');
        // }
      }

      // Print the updated maps
      // if (kDebugMode) {
      //   print(
      //       "Updated English Translations:========================================");
      //   print('English ==== $english');
      //   print('English Length === ${english.length}');
      //   print(
      //       "Updated Arabic Translations:========================================");
      //   print('Arabic ==== ${(json.encode(arabic))}');
      //   print('English Length === ${arabic.length}');
      // }
    } else {
      throw Exception("Document does not exist or has no data");
    }
    // if (doc.exists && doc.data() != null) {
    //   final data = doc.data()!;
    //   final translations = (data['translations'] as List)
    //       .map((translation) => TranslationModel.fromMap(translation))
    //       .toList();

    //   // Clear the lists to avoid duplicates
    //   homePageTranslations.clear();
    //   filtersTranslations.clear();
    //   navigationTranslations.clear();
    //   staticPagesTranslations.clear();
    //   otherTranslations.clear();

    //   // Populate lists based on type
    //   for (var translation in translations) {
    //     switch (translation.type) {
    //       case 'home-page':
    //         homePageTranslations.add(translation);
    //         break;
    //       case 'filters':
    //         filtersTranslations.add(translation);
    //         break;
    //       case 'navigation':
    //         navigationTranslations.add(translation);
    //         break;
    //       case 'static-page':
    //         staticPagesTranslations.add(translation);
    //         break;
    //       default:
    //         otherTranslations.add(translation);
    //         break;
    //     }
    //   }
    // } else {
    //   throw Exception("Document does not exist or has no data");
    // }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching languages: $e');
    }
    rethrow;
  }
});

final getPagesProvider = FutureProvider<PagesData>((ref) async {
  try {
    print('========= Pages data Function =======');
    final doc = await FirebaseFirestore.instance
        .collection('pages')
        .doc('static_pages')
        .get();

    print('document Pages data ==== ${doc.data()}');

    if (doc.exists && doc.data() != null) {
      return PagesData.fromMap(doc.data()!);
    } else {
      throw Exception("Document does not exist or has no data");
    }
  } catch (e) {
    print('Error fetching pages: $e');
    rethrow;
  }
});


//////////////////////////////////////////////////////////////////       Color  Provider    /////////////////////////////////////////////////////////////////
// final getColorProvider = FutureProvider((ref) async {

//   try {
//     final doc = await FirebaseFirestore.instance
//         .collection('color_palettes')
//         .doc('color_palettes')
//         .get();

//     // log('document data ==== ${doc.data()}');
//     if (doc.exists && doc.data() != null) {
//       final data = doc.data()!;
//      var colorPalletee =  (data['color_palettes'] as List) 
//           .map((translation) => TranslationModel.fromMap(translation))
//           .toList();
   
//       // log('Colors has data === $data ');
//       // log('List of english data === ${translations.length}');
//     } else {
//       throw Exception("Document does not exist or has no data");
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error fetching Colors: $e');
//     }
//     rethrow;
//   }
// });

final colorPaletteListProvider = StateProvider<List<ColorPalette>>((ref) => []);

final getColorProvider = FutureProvider<List<ColorPalette>>((ref) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection('color_palettes')
        .doc('color_palettes')
        .get();

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      final colorList = (data['color_palettes'] as List)
          .map((color) => ColorPalette.fromJson(color))
          .toList();
          log('Colors List === ${colorList.length}');
      ref.read(colorPaletteListProvider.notifier).state = colorList;
      return colorList;
    } else {
      throw Exception("Document does not exist or has no data");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching Colors: $e');
    }
    rethrow;
  }
});
