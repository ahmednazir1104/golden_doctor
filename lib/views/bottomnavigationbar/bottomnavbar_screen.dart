import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golden_doctor/utils/app_colors.dart';
import 'package:golden_doctor/utils/app_images.dart';
import 'package:golden_doctor/view_models/home_view_model/home_view_model.dart';
import 'package:golden_doctor/view_models/navigation_view_model/navigation_view_model.dart';
import 'package:golden_doctor/views/authentication/profile_screen.dart';
import 'package:golden_doctor/views/home_screen.dart';
import 'package:golden_doctor/views/navigation_screen/navigation_screen.dart';

import '../cart_screen/cart_screen.dart';

class BottomnavbarScreen extends ConsumerStatefulWidget {
  const BottomnavbarScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomnavbarScreenState();
}

class _BottomnavbarScreenState extends ConsumerState<BottomnavbarScreen> {
  int _selectedIndex = 0;
  List widgetOptions = [
    const HomeScreen(),
    const NavigationScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   print('Dataaaaaaaaaa');
  //      ref.read(uploadProvider.notifier).fetchUserReviews();
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   //   print('Dataaaaaaaaaa');
  //   //   ref.read(uploadProvider.notifier).fetchUserReviews();
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    ref.read(sectionsProvider.notifier).fetchSections();
    ref.read(navigationprovider.notifier).fetchNavigation();
//  ref.watch(sectionsProvider);
    // final sectionsState = ref.watch(sectionsProvider);
    // final authenticationrepository = ref.watch(apiServiceProvider);
    // // final authenticationrepositoryRead = ref.read(apiServiceProvider.notifier); 
    // String userToken = ShearedprefService.getUserAccessToken()!;
    // if (authenticationrepository.profileModel == null) {
    //   authenticationrepository.profile(context, userToken);
    // }
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.homeIcon,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.navigationIcon,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.cartIcon,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.profileIcon,
            ),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        // elevation: 0,
        backgroundColor: AppColors.black1C,
      ),
    );
  }
}
