import 'package:flutter/material.dart';
import 'package:golden_doctor/resources/services/shearedpreference_service.dart';
import 'package:golden_doctor/utils/app_constant.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlHelper {
  GraphQlHelper(){
    print("new object of client");
    print("selected lan ${ AppConstant.selectedLanguage}");

  }
  static HttpLink httpLink = HttpLink(
    

    // 'https://ethnicpk.myshopify.com/api/2024-01/graphql',       // Ethnic
    'https://scrubser.myshopify.com/api/2025-01/graphql', //  screber
    defaultHeaders: <String, String>{
      // 'X-Shopify-Storefront-Access-Token': '959eddd47869314e620a6d1e3d05f6f4',          // Ethnic
      'X-Shopify-Storefront-Access-Token':
          '1acbba2f06475c4427254dd8372b60e7', //scruber
      // 'X-Shopify-Storefront-Access-Token': '75e049669db9a451ebba44c7a193b3f1',
      'Accept': 'application/json',
      'Accept-Language':  ShearedprefService.getLanguage()!
      // 'en'
      // AppConstant.selectedLanguage == 'en'
      //     ? 'en'
      //     : 'ar',
      
    },
  );
  
  static Link linke = httpLink;
  ValueNotifier<GraphQLClient> client = ValueNotifier(
  
    GraphQLClient(
    
    cache: GraphQLCache(),
    link: linke,
  ));

  GraphQLClient clientToQuery() {
    return GraphQLClient(link: linke, cache: GraphQLCache());
  }
}
