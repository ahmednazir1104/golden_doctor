// String fetchProductwithCollectionIdfn(String id, {String? cursor}) {
//   return '''query FetchProducts(\$numProducts: Int!, \$cursor: String) {
//       collection(id: "$id") {
//         products(first: \$numProducts, after: \$cursor) {
//           edges {
//             cursor
//             node {
//               title
//               tags
//               description
//               descriptionHtml
//               productType
//               publishedAt
//               onlineStoreUrl
//               options{
//               name
//               values
//             }
//               variants(first: 30) {
//                 edges {
//                   node {
//                     id
//                     title
//                     image {
//                       src
//                     }
//                     price {
//                       amount
//                     }
//                     sku
//                     compareAtPrice{
//                       amount
//                     }
//                     availableForSale

//                     selectedOptions {
//                       name
//                       value
//                     }
//                   }
//                 }
//               }
//               images(first: 30) {
//                 edges {
//                   node {
//                     url
//                     altText
//                   }
//                 }
//               }
//                metafields(identifiers:[
//                   {
//                       namespace: "custom",
//                       key: "product_recomandation"
//                 },
//                  {
//                       namespace: "custom",
//                       key: "you_may_also_like"
//                 },
//                 {
//                       namespace: "custom",
//                       key: "embroidery_product"
//                 },

//                 ]
//                 ){
//                 key
//                 value
//               }
//               id
//             }
//           }
//           pageInfo {
//           hasNextPage
//           hasPreviousPage
//           startCursor
//           endCursor
//           }
//         }
//       }
//     }''';
// }

String fetchProductwithCollectionIdfn(String id, {String? cursor}) {
  return '''query FetchProducts(\$numProducts: Int!, \$cursor: String) {
        collection(id: "$id") {
            products(first: \$numProducts, after: \$cursor) {
            edges {
                cursor
                node {
                    title
                    vendor
                    tags
                    description
                    descriptionHtml
                    productType
                    publishedAt
                    onlineStoreUrl
                    options{
                        name
                        optionValues{
                            name
                        }
                    }
                    variants(first: 30) {
                        edges {
                            node {
                                id
                                title
                                image {
                                    url
                                }
                                price {
                                    amount
                                }
                                sku
                                compareAtPrice {
                                    amount
                                }
                                availableForSale
                                selectedOptions {
                                    name
                                    value
                                }
                            }
                        }
                    }
                    images(first: 30) {
                        edges {
                            node {
                                url
                                altText
                            }
                        }
                    }
                    metafields(identifiers: [
                                {namespace: "custom",key: "product_recomandation"
                                },
                                {namespace: "custom", key: "embroidery_product"
                                }
                                {namespace: "custom", key: "you_may_also_like"
                                }
                            ]) {
                        key
                        value
                    }
                    id
                }
            }
            pageInfo {
                hasNextPage
                hasPreviousPage
                startCursor
                endCursor
            }
        }
    }
}
''';
}
// metafield(namespace:"custom",key:"fit"){
//                 key
//                 value
//               }

String fetchProductListByIDs(String productIDs) {
  return '''query getProductsByIds {
  	nodes(ids: [$productIDs
    ]){ 
    	... on 
      Product {
        title
                    vendor
                    tags
                    description
                    descriptionHtml
                    productType
                    publishedAt
                    onlineStoreUrl
                    options{
                        name
                        optionValues{
                            name
                        }
                    }
                    variants(first: 30) {
                        edges {
                            node {
                                id
                                title
                                image {
                                    url
                                }
                                price {
                                    amount
                                }
                                sku
                                compareAtPrice {
                                    amount
                                }
                                availableForSale
                                selectedOptions {
                                    name
                                    value
                                }
                            }
                        }
                    }
                    images(first: 30) {
                        edges {
                            node {
                                url
                                altText
                            }
                        }
                    }
                    metafields(identifiers: [
                                {namespace: "custom",key: "product_recomandation"
                                },
                                {namespace: "custom", key: "embroidery_product"
                                }
                                {namespace: "custom", key: "you_may_also_like"
                                }
                            ]) {
                        key
                        value
                    }
                    id
      }
    }
}
''';
}

String fetchSignleProduct(String productID) {
  return '''query{
      product(id: "$productID") {
        title
        vendor
        tags
        description
        descriptionHtml
        productType
        publishedAt
        onlineStoreUrl
        options{
            name
            optionValues{
                name
            }
        }
        variants(first: 30) {
            edges {
                node {
                    id
                    title
                    image {
                        url
                    }
                    price {
                        amount
                    }
                    sku
                    compareAtPrice{
                        amount
                    }
                    availableForSale
                    selectedOptions {
                        name
                        value
                    }
                }
            }
        }
        images(first: 30) {
            edges {
                node {
                    url
                    altText
                }
            }
        }
        metafields(identifiers: [
                    {namespace: "custom",key: "product_recomandation"
                    },
                    {namespace: "custom", key: "embroidery_product"
                    }
                    {namespace: "custom", key: "you_may_also_like"
                    }
                ]) {
            key
            value
        }
        id
      }
    }''';
}

String fetchAllOrders(String userToken) {
  return '''query{
    customer(customerAccessToken: "$userToken") {
        id,
        firstName,
        lastName,
        
        orders(first: 10) {
            edges {
                node {
                    
                    id
                    name
                    
                    totalPrice{
                        amount
                    }
                    subtotalPrice{
                amount
            }
            totalTax{
                amount
            }
                    fulfillmentStatus
                    
                     lineItems(first: 250) {
                edges {
                    node {
                        quantity
                        title
                        
                        
                    }
                }
            }
                }
            }
        }
    }
}''';
}

// """
// query ReadCollection(\$CollectionId: ID!) {

//     node(id: \$CollectionId) {
//     ... on Collection {
//       id
//       title
//      description
//       products(first: 5) {
//          pageInfo {
//           hasNextPage
//           hasPreviousPage
// startCursor
//             endCursor
//         }
//         edges {
//           cursor
//           node {
//             title
//             tags
//             description
//             descriptionHtml
//             productType
//             publishedAt
//             onlineStoreUrl
//             variants(first: 10) {
//               edges {
//                 node {
//                   id
//                   image {
//                     url
//                   }
//                   price {
//                     amount
//                   }
//                   sku
//                   compareAtPrice {
//                     amount
//                   }
//                   availableForSale
//                   selectedOptions {
//                     name
//                     value
//                   }
//                 }
//               }
//             }
//             images(first: 10) {
//               edges {
//                 node {
//                   src
//                 }
//               }
//             }
//             id
//           }
//         }
//       }
//     }
//   }
//   }

// """;

// const String fetchProductwithoutCollectionId = """
//     query {
//       products(first: 5) {
//          pageInfo {
//           hasNextPage
//           hasPreviousPage
//           startCursor
//           endCursor
//         }
//         edges {
//           cursor
//           node {
//             title
//             tags
//             description
//             descriptionHtml
//             productType
//             publishedAt
//             onlineStoreUrl
//             variants(first: 10) {
//               edges {
//                 node {
//                   id
//                   image {
//                     url
//                   }
//                   price {
//                     amount
//                   }
//                   sku
//                   compareAtPrice {
//                     amount
//                   }
//                   availableForSale
//                   selectedOptions {
//                     name
//                     value
//                   }
//                 }
//               }
//             }
//             images(first: 10) {
//               edges {
//                 node {
//                   src
//                 }
//               }
//             }
//             id
//           }
//         }
//       }
//     }
// """;

const String finalsearchProducts =
    """  query ReadProductsByTag(\$Search: String!) {
  products(first: 39, query: \$Search) {
      edges {
          cursor
          node {
              title
              vendor
              tags
              description
              descriptionHtml
              productType
              publishedAt
              onlineStoreUrl
              options{
                  name
                  optionValues{
                      name
                  }
              }
              variants(first: 30) {
                  edges {
                      node {
                          id
                          title
                          image {
                              url
                          }
                          price {
                              amount
                          }
                          sku
                          compareAtPrice {
                              amount
                          }
                          availableForSale
                          selectedOptions {
                              name
                              value
                          }
                      }
                  }
              }
              images(first: 30) {
                  edges {
                      node {
                          url
                          altText
                      }
                  }
              }
              metafields(identifiers: [
                          {namespace: "custom",key: "product_recomandation"
                          },
                          {namespace: "custom", key: "embroidery_product"
                          }
                          {namespace: "custom", key: "you_may_also_like"
                          }
                      ]) {
                  key
                  value
              }
              id
          }
      }
      pageInfo {
          hasNextPage
          hasPreviousPage
          startCursor
          endCursor
      }
  }
}

""";

String signUpQuery({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
}) {
  return '''{"query":"mutation customerCreate(\$input: CustomerCreateInput!) {\\n  customerCreate(input: \$input) {\\n    customer {\\n      id\\n      email\\n      firstName\\n      lastName\\n    }\\n    customerUserErrors {\\n      code\\n      field\\n      message\\n    }\\n  }\\n}\\n\\n\\n\\n\\n# mutation SignInWithEmailAndPassword(\\n#     \$email: String!, \\n#     \$password: String!,\\n# ) {\\n#     customerAccessTokenCreate(input: { \\n#         email: \$email, \\n#         password: \$password,\\n#     }) {\\n#         customerAccessToken {\\n#             accessToken\\n#             expiresAt\\n#         }\\n#         customerUserErrors {\\n#             code\\n#             message\\n#         }\\n#     }\\n# }","variables":{"input":{"email":"$email","password":"$password","firstName":"test","lastName":"test"}}}''';
}

String signInQuery({
  required String email,
  required String password,
}) {
  return '''{"query":"mutation SignInWithEmailAndPassword(\\n    \$email: String!, \\n    \$password: String!,\\n) {\\n    customerAccessTokenCreate(input: { \\n        email: \$email, \\n        password: \$password,\\n    }) {\\n        customerAccessToken {\\n            accessToken\\n            expiresAt\\n        }\\n        customerUserErrors {\\n            code\\n            message\\n        }\\n    }\\n}","variables":{"email":"${email.toString()}","password":"${password.toString()}"}}''';
}

String profileQuery({required String token}) {
  return '''{"query":"query {\\n  customer(customerAccessToken: \\"$token\\") {\\n    id\\n    firstName\\n    lastName\\n    email\\n    phone\\n    defaultAddress {\\n      id\\n      address1\\n      address2\\n      city\\n      province\\n      country\\n      zip\\n    }\\n  }\\n}","variables":{}}''';
}

String reSetPasswordQuery({required String email}) {
  return '''{"query":"mutation customerRecover(\$email: String!) {\\n  customerRecover(email: \$email) {\\n    customerUserErrors {\\n     code,\\n     message\\n    }\\n  }\\n}","variables":{"email":"$email"}}''';
}

String productQuantityQuery({required String productId}) {
  return '''{"query":"\\n\\n\\nquery MyQuery {\\n  product(id: \\"$productId\\") {\\n    totalInventory\\n    variants(first: 100) {\\n      edges {\\n        node {\\n          quantityAvailable\\n          id\\n        }\\n      }\\n    }\\n  }\\n}","variables":{"id":"$productId"}}''';
}

String newCartQuery(dynamic listofItems) {
  return '''mutation {
  cartCreate(input: {
    lines: $listofItems
    }
) {
    cart {
      id
      createdAt
      updatedAt
      lines(first: 5) {
        edges {
          node {
            id
            quantity
            attribute(key: "your-key"){
                key
                value
            }
            merchandise {
              ... on ProductVariant {
                id
                title
                priceV2 {
                  amount
                  currencyCode
                }
              }
            }
          }
        }
      }
    }
  },
  
}
''';
}

String addToCartQuery({required List productListString}) {
  return ''' {
    mutation createCart( "$productListString": String) {  
        cartCreate(input: "$productListString") {    
            cart {      
                id      
                createdAt      
                updatedAt      
                lines(first: 10) {        
                    edges {          
                        node {            
                            id            
                            merchandise {              
                                ... on ProductVariant {                id              
                                }            
                            }            
                            properties {              
                                    key       
                                    value            
                            }          
                        }        
                    }      
                }      
                attributes {        
                    key        
                    value      
                }      
                estimatedCost {        
                    totalAmount {          
                        amount          
                        currencyCode        
                    }        
                    subtotalAmount {          
                        amount          
                        currencyCode
                    }        
                    totalTaxAmount {          
                        amount          
                        currencyCode        
                    }        
                    totalDutyAmount {          
                        amount          
                        currencyCode
                    }      
                }    
            }  
        }
    },
}
''';
  // return '''{"query":"mutation createCart(\$cartInput: CartInput) {\n  cartCreate(input: \$cartInput) {\n    cart {\n      id\n      createdAt\n      updatedAt\n      lines(first: 10) {\n        edges {\n          node {\n            id\n            merchandise {\n              ... on ProductVariant {\n                id\n              }\n            }\n            properties {\n              key\n              value\n            }\n          }\n        }\n      }\n      attributes {\n        key\n        value\n      }\n      estimatedCost {\n        totalAmount {\n          amount\n          currencyCode\n        }\n        subtotalAmount {\n          amount\n          currencyCode\n        }\n        totalTaxAmount {\n          amount\n          currencyCode\n        }\n        totalDutyAmount {\n          amount\n          currencyCode\n        }\n      }\n    }\n  }\n}','variables':{"cartInput":{"lines":$productListString}}}''';
  // return '''{"query":"mutation createCart(\$cartInput: CartInput, ) {\\n  cartCreate(input: \$cartInput,) {\\n    cart {\\n      id\\n      createdAt\\n      updatedAt\\n      lines(first:10) {\\n        edges {\\n          node {\\n            id\\n            merchandise {\\n              ... on ProductVariant {\\n                id\\n              }\\n            }\\n          }\\n        }\\n\\n      }\\n      attributes {\\n        key\\n        value\\n      }\\n      estimatedCost {\\n        totalAmount {\\n          amount\\n          currencyCode\\n        }\\n        subtotalAmount {\\n          amount\\n          currencyCode\\n        }\\n        totalTaxAmount {\\n          amount\\n          currencyCode\\n        }\\n        totalDutyAmount {\\n          amount\\n          currencyCode\\n        }\\n      }\\n    }\\n  }\\n}\\n","variables":{"cartInput":{"lines":$productListString}}}''';
}

String checkOutQuery({required String cartId}) {
  return '''{"query":"query checkoutURL {\\n  cart(id: \\"$cartId\\") {\\n    checkoutUrl\\n  }\\n}","variables":{}}''';
}







  // products(first: 5, query: \$Search) {
  
  //   edges {
  //     cursor
  //     node {
  //       title
  //       tags
  //       description
  //       descriptionHtml
  //       productType
  //       publishedAt
  //       onlineStoreUrl
  //       variants(first: 1) {
  //             edges {
  //               node {
  //                 id
  //                 title
  //               #   inventoryQuantity
  //                 image {
  //                   src
  //                 }
  //                 price{
  //                   amount
  //                 }
  //                 sku
  //                 compareAtPrice{
  //                   amount
  //                 }
  //                 availableForSale
  //                 selectedOptions {
  //                   name
  //                   value
  //                 }
  //               }
  //             }
  //           }
  //       images(first: 1) {
  //             edges {
  //               node {
  //                 src
  //               }
  //             }
  //           }
  //       options(first: 2) {
  //         name
  //         values
  //       }
  //       id
  //     }
  //   }
  // }

  