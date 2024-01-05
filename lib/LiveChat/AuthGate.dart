// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutterfire_ui/auth.dart';
// import 'homepage.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   MyApp({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(primarySwatch: Colors.indigo),
// //       themeMode: ThemeMode.light,
// //       home: AuthGate(),
// //     );
// //   }
// // }

// class AuthGate extends StatefulWidget {
//   AuthGate({Key? key}) : super(key: key);

//   @override
//   State<AuthGate> createState() => _AuthGateState();
// }

// class _AuthGateState extends State<AuthGate> {
//   lad() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//   }

//   final auth = FirebaseAuth.instance;
//   @override
//   void initState() {
//     if (auth.currentUser == null) {
//       auth.signOut();
//     }
//     lad();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return MyHomePage();
//         } else {
//           return SignInScreen(
//             providerConfigs: [EmailProviderConfiguration()],
//           );
//         }
//       },
//     );
//   }
// }
