import 'dart:async';
import 'package:cableproject/view/authentication/Home.dart';
import 'package:cableproject/view/authentication/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/app_image.dart';

class Splash extends StatefulWidget {
  Splash({super.key});
  static String routeName = './Splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoading = true;
  bool isLoggedIn = false;
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool("isLoggedIn");
    setState(() {
      isLoggedIn = loggedIn ?? false;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkLogin();

    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => isLoggedIn ? Home() : Login())));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: FlutterLogo(
              size: 150,
            ),
          ),
        ),
      ),
    );
  }
}










// .....................
// import 'dart:async';

// import 'package:cableproject/view/authentication/Home.dart';
// import 'package:cableproject/view/authentication/Home.dart';
// import 'package:cableproject/view/authentication/login.dart';
// import 'package:cableproject/view/authentication/notification.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../utilities/app_image.dart';

// class Splash extends StatefulWidget {
//   Splash({super.key});
//   static String routeName = './Splash';

//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   ConnectionState status = ConnectionState.none;
//   StreamSubscription<ConnectivityResult>? _connectivitySubscription;
//   final connectivity = Connectivity();

//   void networkCheck() async {
//     final result = await connectivity.checkConnectivity();
//     status = result == ConnectivityResult.none
//         ? ConnectionState.none
//         : ConnectionState.active;
//     // connectivity.onConnectivityChanged.listen((event) {
//     //   status = result == ConnectivityResult.none
//     //       ? ConnectionState.none
//     //       : ConnectionState.active;
//     // });
//     print(status);

//     Future.delayed(
//       Duration(seconds: 2),
//       () => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => status== ConnectionState.none? NotificationPage() : Login()),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     networkCheck();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             child: FlutterLogo(
//               size: 150,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:cableproject/view/authentication/Home.dart';
// import 'package:cableproject/view/authentication/Home.dart';
// import 'package:cableproject/view/authentication/login.dart';
// import 'package:cableproject/view/authentication/notification.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../utilities/app_image.dart';

// class Splash extends StatefulWidget {
//   Splash({super.key});
//   static String routeName = './Splash';

//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   ConnectionState status = ConnectionState.none;

//   late final Connectivity _connectivity;

//   StreamSubscription<ConnectivityResult>? _connectivitySubscription;
//   bool isLoading = true;
//   bool isLoggedIn = false;

//   Future<void> checkLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? loggedIn = prefs.getBool("isLoggedIn");
//     setState(() {
//       isLoggedIn = loggedIn ?? false;
//       isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkLogin();
//     _connectivity = Connectivity();
//     _initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

//     Future.delayed(
//       Duration(seconds: 2),
//       () => Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => status == ConnectionState.none
//                 ? NotificationPage()
//                 : isLoggedIn
//                     ? Home()
//                     : Login()),
//       ),
//     );
//   }

//   Future<void> _initConnectivity() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       _updateConnectionStatus(result);
//     } on PlatformException catch (e) {
//       print('Platform error checking connectivity: $e');
//       setState(() {
//         status = ConnectionState.none;
//       });
//     } catch (e) {
//       print('Error checking connectivity: $e');
//       setState(() {
//         status = ConnectionState.none;
//       });
//     }
//   }

//   void _updateConnectionStatus(ConnectivityResult result) {
//     if (!mounted) return;

//     setState(() {
//       switch (result) {
//         case ConnectivityResult.wifi:
//           status = ConnectionState.active;
//           break;
//         case ConnectivityResult.mobile:
//           status = ConnectionState.active;
//           break;
//         case ConnectivityResult.none:
//           status = ConnectionState.none;
//           break;
//         default:
//           status = ConnectionState.none;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             child: FlutterLogo(
//               size: 150,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
