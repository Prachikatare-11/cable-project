// import 'package:cableproject/utilities/app_button.dart';
// import 'package:cableproject/utilities/app_color.dart';
// import 'package:cableproject/utilities/app_constant.dart';
// import 'package:cableproject/utilities/app_font.dart';
// import 'package:cableproject/utilities/app_image.dart';
// import 'package:cableproject/utilities/app_language.dart';
// import 'package:cableproject/view/authentication/Home.dart';
// import 'package:cableproject/view/authentication/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class logout extends StatefulWidget {
//   const logout({super.key});

//   @override
//   State<logout> createState() => _logoutState();
// }

// class _logoutState extends State<logout> {
//   void logOutPopUp(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: AppColor.primaryColor.withOpacity(0.1),
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 100 / 100,
//                 height: MediaQuery.of(context).size.height * 100 / 100,
//                 color: AppColor.primaryColor.withOpacity(0.1),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       clipBehavior: Clip.none,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 82 / 100,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 35, horizontal: 15),
//                           decoration: BoxDecoration(
//                               color: AppColor.secondryColor,
//                               borderRadius: BorderRadius.circular(0)),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height *
//                                     1 /
//                                     100,
//                               ),
//                               Center(
//                                 child: Text(
//                                   AppLanguage.logoutText[language],
//                                   style: const TextStyle(
//                                       color: AppColor.primaryColor,
//                                       fontFamily: AppFont.fontFamily,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 20),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height *
//                                     1 /
//                                     100,
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width *
//                                     60 /
//                                     100,
//                                 child: Text(
//                                   AppLanguage.sureLogOutText[language],
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                       color: AppColor.textColor,
//                                       fontFamily: AppFont.fontFamily,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height *
//                                     3 /
//                                     100,
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width *
//                                     82 /
//                                     100,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Container(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 30 /
//                                                 100,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 5 /
//                                                 100,
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: AppColor.themeColor),
//                                             borderRadius:
//                                                 BorderRadius.circular(29)),
//                                         child: Text(
//                                           AppLanguage.noText[language],
//                                           style: const TextStyle(
//                                               color: AppColor.themeColor,
//                                               fontFamily: AppFont.fontFamily,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 16),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           7 /
//                                           100,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Navigator.pop(context);
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                      Login()));
//                                       },
//                                       child: Container(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 30 /
//                                                 100,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 5 /
//                                                 100,
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             gradient: AppColor.buttonGradient,
//                                             borderRadius:
//                                                 BorderRadius.circular(29)),
//                                         child: Text(
//                                           AppLanguage.yesText[language],
//                                           style: const TextStyle(
//                                               color: AppColor.secondaryColor,
//                                               fontFamily: AppFont.fontFamily,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 16),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 82 / 100,
//                             height:
//                                 MediaQuery.of(context).size.height * 1.2 / 100,
//                             color: AppColor.themeColor,
//                           ),
//                         ),
//                         Positioned(
//                           top: -MediaQuery.of(context).size.height * 2.8 / 100,
//                           child: Image.asset(
//                             AppImage.logOutThemeIcon,
//                             fit: BoxFit.cover,
//                             width: MediaQuery.of(context).size.width * 14 / 100,
//                             height:
//                                 MediaQuery.of(context).size.width * 14 / 100,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           });
//         });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
