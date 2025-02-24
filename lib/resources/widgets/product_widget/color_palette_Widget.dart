import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_doctor/models/products/product_model.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_fonts.dart';
import 'package:golden_doctor/view_models/fonts_view_model.dart';
import 'package:golden_doctor/view_models/product_details_view_model.dart';

// var list = [
//   {
//     "title": "black",
//     "code": "0xFF000000",
//   },
//   {
//     "title": "green",
//     "code": "0xFF00C817",
//   },
//   {
//     "title": "white",
//     "code": "0xffFAFAFA",
//   },
//   {
//     "title": "yello",
//     "code": "0xffFFFF00",
//   },
//   {
//     "title": "orange",
//     "code": "0xffFFA500",
//   },
//   {
//     "title": "red",
//     "code": "0xffC20E0F",
//   },
//   {
//     "title": "white",
//     "code": "0xffFAFAFA",
//   },
// ];

class ColorPalateWidget extends ConsumerStatefulWidget {
  final String optionKey;
  final String optionValue;
  final String uniquePageKey;
  const ColorPalateWidget({
    super.key,
    required this.optionKey,
    required this.optionValue,
    required this.uniquePageKey,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ColorPalateWidgetState();
}

class _ColorPalateWidgetState extends ConsumerState<ColorPalateWidget> {
  @override
  Widget build(BuildContext context) {
    final colorList = ref.watch(colorPaletteListProvider);
    final optionsWatch = ref.watch(productDetailsProvider(widget.uniquePageKey));
    final optionsRead = ref.read(productDetailsProvider(widget.uniquePageKey).notifier);
    var code = colorList.firstWhereOrNull((e) {
      return e.colorName == widget.optionValue;
    });
    return code == null
        ? GestureDetector(
            onTap: () {
              // AppConstant.selectedColor = widget.colorName;
              var temp = optionsWatch.selectedOptions;
              // temp.add(SelectedOption(
              //   name: widget.optionKey,
              //   value: widget.optionValue,
              // ));
              temp[temp.indexWhere((e) => e.name == widget.optionKey)] =
                  SelectedOption(
                name: widget.optionKey,
                value: widget.optionValue,
              );
              optionsRead.selectOption(temp);
            },
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 70.w, // Ensure consistent width
              decoration: BoxDecoration(
                border: Border.all(
                  color: optionsWatch.selectedOptions
                              .firstWhere((x) => x.name == widget.optionKey)
                              .value ==
                          widget.optionValue
                      ? AppColors.black1C
                      : Colors.grey,
                  width: optionsWatch.selectedOptions
                              .firstWhere((x) => x.name == widget.optionKey)
                              .value ==
                          widget.optionValue
                      ? 2
                      : 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.optionValue,
                  style: AppTextStyles.lable3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              List<SelectedOption> temp = optionsWatch.selectedOptions;
              // temp.add(SelectedOption(
              //   name: widget.optionKey,
              //   value: widget.optionValue,
              // ));
              temp[temp.indexWhere((e) => e.name == widget.optionKey)] =
                  SelectedOption(
                name: widget.optionKey,
                value: widget.optionValue,
              );
              optionsRead.selectOption(temp);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Container(
                height: 35.h,
                width: 35.w,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: optionsWatch.selectedOptions
                                .firstWhere((x) => x.name == widget.optionKey)
                                .value ==
                            widget.optionValue
                        ? AppColors.black1C
                        : Colors.transparent,
                    width: 1,
                  ),
                  color: AppColors.myScaffold,
                ),
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: optionsWatch.selectedOptions
                                  .firstWhere((x) => x.name == widget.optionKey)
                                  .value ==
                              widget.optionValue
                          ? AppColors.black1C
                          : Colors.transparent,
                      width: 1,
                    ),
                    color: Color(int.parse((code.hexCode).toString())),
                  ),
                  child: Center(
                    child: optionsWatch.selectedOptions
                                .firstWhere((x) => x.name == widget.optionKey)
                                .value ==
                            widget.optionValue
                        ? Icon(
                            Icons.check,
                            color: AppColors.myScaffold,
                            size: 12,
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ),
          );
  }
}
