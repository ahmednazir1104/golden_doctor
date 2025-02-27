import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_doctor/graph_ql/query/mutation_query.dart';
import 'package:golden_doctor/models/authentication/profile_model.dart';
import 'package:golden_doctor/resources/services/shearedpreference_service.dart';
import 'package:golden_doctor/utils/app_textfield_controllers.dart';
import 'package:golden_doctor/utils/handles.dart';
// import 'package:http/http.dart' as http;

// final obscureProvider = StateProvider<bool>((ref) => true);

class ApiClass extends ChangeNotifier {
  bool boleanValue = false;
  bool isUserLogedIn = ShearedprefService.getUserLoggedIn();
  ProfileModel? profileModel;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  void addboleanValue(bool todo) {
    boleanValue = todo;
    notifyListeners();
  }

// set User`s login status.
  setUserLoginStatus(value) {
    isUserLogedIn = value;
    notifyListeners();
  }

// sign up
  Future<void> signUp(
    BuildContext context,
    String email,
    String passsword,
    String firstName,
    String lastName,
  ) async {
    addboleanValue(true);
    Future.delayed(Duration(seconds: 7)).then(
      (value) {
        if (boleanValue == true) {
          addboleanValue(false);
          return Fluttertoast.showToast(msg: "Try again later");
        }
      },
    );
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    String body = signUpQuery(
        email: email,
        password: passsword,
        firstName: firstName,
        lastName: lastName);
    var response = await apiBaseHelper.post(url: '', data: body);
    // print(response);
    if (response['data']['customerCreate']["customerUserErrors"].toString() ==
        "[]") {
      // print(await response.stream.bytesToString());
      Fluttertoast.showToast(
        msg: " You have successfully Signup ",
      );

      // addboleanValue(false);
      // AppTextfieldControllers.claerControllers();
      // context.pushReplacement('/loginScreen');
      login(context, email, passsword);
    } else {
      if (kDebugMode) {
        print("Error1");
        print(response);
      }
      Fluttertoast.showToast(
        msg: response['data']['customerCreate']["customerUserErrors"][0]
                ["message"]
            .toString(),
      );
      addboleanValue(false);
    }
  }

// login
  Future<void> login(
    BuildContext context,
    String email,
    String passsword,
  ) async {
    addboleanValue(true);
    Future.delayed(Duration(seconds: 7)).then(
      (value) {
        if (boleanValue == true) {
          return addboleanValue(false);
        }
      },
    );
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    String body = signInQuery(
      email: email,
      password: passsword,
    );
    Map<String, dynamic> response =
        await apiBaseHelper.post(url: '', data: body);
    log('Response ===== $response');
    if (response['data']['customerAccessTokenCreate']["customerUserErrors"]
            .toString() ==
        "[]") {
      String accessToken = response['data']['customerAccessTokenCreate']
          ['customerAccessToken']['accessToken'];
      ShearedprefService.setUserGmail(email);
      ShearedprefService.setintroScreen(true);
      ShearedprefService.setUserAccessToken(accessToken);
      ShearedprefService.setUserLoggedIn(true);

      Fluttertoast.showToast(msg: "You have successfully Login ");

      addboleanValue(false);
      AppTextfieldControllers.claerControllers();
      setUserLoginStatus(true);
      context.go("/nav_barScreen");
    } else {
      if (kDebugMode) {
        print("Error");
      }
      log('Error ===== Error');
      Fluttertoast.showToast(
        msg: response['data']['customerAccessTokenCreate']["customerUserErrors"]
            [0]["message"],
      );
      addboleanValue(false);
    }
  }

// logout
  logOut(BuildContext context) {
    ShearedprefService.setUserLoggedIn(false);
    ShearedprefService.setUserAccessToken("");
    profileModel = null;
    // ShearedprefService.logoutAccount().then((value) {
    //   ShearedprefService.setUserLoggedIn(false);
    //   ShearedprefService.setUserAccessToken("");
    // });
    setUserLoginStatus(false);
    Fluttertoast.showToast(msg: " Logout Successfully ");
    // context.go("/wellcomeScreen");
  }

// Profile
  Future<void> profile(
 
    String token,
  ) async {
    addboleanValue(true);
    String userToken = ShearedprefService.getUserAccessToken()!;

    try {
      final response = await http.post(
        Uri.parse('https://scrubser.myshopify.com/api/2025-01/graphql.json'),
        headers: {
          'Content-Type': 'application/json',
          'X-Shopify-Storefront-Access-Token':
              '1acbba2f06475c4427254dd8372b60e7',
        },
        body: json.encode({
          'query': '''
        query GetCustomer(\$customerAccessToken: String!) {
          customer(customerAccessToken: \$customerAccessToken) {
            id
            firstName
            lastName
            email
            phone
            acceptsMarketing
          }
        }
      ''',
          'variables': {
            'customerAccessToken': userToken,
          },
        }),
      );

      // print('Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');
      // print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log('response === $data');
        profileModel = ProfileModel.fromJson(data['data']['customer']);
        log('Customer Data: ${profileModel!.email}');
        log('Customer Data: $profileModel');
        // print('Customer Data: $profileModel');
        // print('Customer Data: $data');
        addboleanValue(false);
      } else {
        print('Error: ${response.statusCode}');
        addboleanValue(false);
      }
    } catch (e) {
      print('Exception: $e');
      addboleanValue(false);
    }
  }

// changePassword
  Future<void> changeUserPassword(
    BuildContext context,
    String email,
  ) async {
    addboleanValue(true);
    Future.delayed(Duration(seconds: 7)).then(
      (value) {
        if (boleanValue == true) {
          return addboleanValue(false);
        }
      },
    );
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    String body = reSetPasswordQuery(email: "email");
    Map<String, dynamic> response =
        await apiBaseHelper.post(url: '', data: body);
    if (kDebugMode) {
      print(response);
      print("1: ${response['data']['customerRecover'].toString()}");
      print("2: ${response['data']['errors'].toString()}");
      print("3: ${response['data']['customerUserErrors'].toString()}");
    }
    if (response['data']['customerRecover'].toString() == "null") {
      Fluttertoast.showToast(msg: response['errors'][0]['message']);
      // profileModel = ProfileModel.fromJson(accessToken);
      context.pop();
      addboleanValue(false);
    } else if (response['data']['customerRecover']["customerUserErrors"]
            .toString() ==
        "[]") {
      Fluttertoast.showToast(msg: "Email Send to your Gmail");

      context.pop();
      addboleanValue(false);
    } else if (response['data']['customerRecover']["customerUserErrors"]
            .toString() !=
        "[]") {
      Fluttertoast.showToast(msg: response['data']['errors']['message']);
      // profileModel = ProfileModel.fromJson(accessToken);
      // context.pop();
      addboleanValue(false);
    } else {
      Fluttertoast.showToast(msg: "try again");
      // profileModel = ProfileModel.fromJson(accessToken);
      // context.pop();
      addboleanValue(false);
    }
  }

// Starting Social Authentication From here
//    1. Google Authentication

  // Future signInWithGoogle() async {
  //   try {
  //     log('start fun ');
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     log('start fun  1111 ');
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     log('start fun 222');
  //     log('Token === ${googleSignInAuthentication.accessToken}');
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     log('start fun  33333 ');

  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     log('credentials === ${userCredential.user!.displayName}');

  //     log('start fun  44444');
  //     final User? user = userCredential.user;
  //     log('start fun 55555');
  //     log('user === ${user!.displayName}');
  //     // Use the user object for further operations or navigate to a new screen.
  //   } catch (e) {
  //     print(e.toString());
  //   }

  //   // Trigger the authentication flow
  //   // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   // final GoogleSignInAuthentication? googleAuth =
  //   //     await googleUser?.authentication;

  //   // log('Access Token = ${googleAuth?.accessToken}');
  //   // log('Access Token = ${googleAuth?.idToken}');
  //   // Create a new credential

  //   // final credential = GoogleAuthProvider.credential(
  //   //   accessToken: googleAuth?.accessToken,
  //   //   idToken: googleAuth?.idToken,
  //   // );

  //   // // Once signed in, return the UserCredential
  //   // return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}

final apiServiceProvider = ChangeNotifierProvider<ApiClass>((ref) {
  return ApiClass();
});
