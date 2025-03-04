import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/models/home_model/brand_section_model.dart';
import 'package:golden_doctor/models/home_model/category_section_model.dart';
import 'package:golden_doctor/models/home_model/maching_pair_model.dart';
import 'package:golden_doctor/models/home_model/product_section_model.dart';
import 'package:golden_doctor/models/home_model/single_banner_section.dart';
import 'package:golden_doctor/resources/widgets/home_widgets/brand_widget.dart';
import 'package:golden_doctor/resources/widgets/home_widgets/maching_pair_widget.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/resources/widgets/home_widgets/category_carousel_widget.dart';
import 'package:golden_doctor/resources/widgets/home_widgets/product_carusel_widget.dart';
import 'package:golden_doctor/resources/widgets/home_widgets/single_banner_widget.dart';
import 'package:golden_doctor/view_models/authentication_view_model.dart';
import 'package:golden_doctor/view_models/home_view_model/home_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionsState = ref.watch(sectionsProvider);
    final authenticationrepository = ref.watch(apiServiceProvider);
    final authenticationrepositoryRead = ref.read(apiServiceProvider.notifier);

    // final selectedLanguage = ref.watch(languageProvider);

    // Check if the selected language is right-to-left
    // final isRtl = selectedLanguage == Language.arabic ||
    //     selectedLanguage == Language.urdu;
    return Directionality(
      textDirection: AppConstant.selectedLanguage == 'EN'
          ? TextDirection.ltr
          : TextDirection.rtl,
      //  isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.horizantelLogo, height: 32),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search_rounded,
              ),
              onPressed: () {
                context.push('/search_screen');
              },
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.barcode_viewfinder,
              ),
              onPressed: () async {
                context.push('/brandScreen');
              },
            ),
          ],
        ),
        body: sectionsState.when(
          data: (sectionsModel) {
            if (sectionsModel == null || sectionsModel.sections.isEmpty) {
              return Center(
                  child: Text(
                "No sections available",
                style: AppTextStyles.body1,
              ));
            }
            return ListView.builder(
              itemCount: sectionsModel.sections.length,
              itemBuilder: (context, index) {
                final section = sectionsModel.sections[index];

                // if (section is MatchingPairsSection) {
                //   return MachingPairWidgetWidget(
                //     section: section,
                //   );

                // } else {

                // }
                return _buildSectionBody(section);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
              child: Text(
            "Error: $error",
            style: AppTextStyles.body1,
          )),
        ),
      ),
    );
  }

  Widget _buildSectionBody(section) {
    if (section is MatchingPairsSection) {
      return MachingPairWidgetWidget(
        section: section,
      );
    } else if (section is CategoriesCarouselSection) {
      return CategoryCarouselWidget(
        section: section,
      );
    } else if (section is BrandSection) {
      return BrandWidget(
        section: section,
      );
    } else if (section is ProductsCarouselSection) {
      return ProductCaruselWidget(
        section: section,
      );
    } else if (section is SingleBannerSection) {
      return SingleBannerWidget(
        section: section,
      );
    }
    {
      return SizedBox.shrink();
    }
  }
}
