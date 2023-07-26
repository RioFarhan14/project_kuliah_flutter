import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_pi/pages/login.dart';
import 'firebase_options.dart';

import 'package:project_pi/pages/splash.dart';
import 'package:project_pi/pages/home.dart'; // Impor file home.dart

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Tambahkan initialRoute jika diperlukan
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => Login(), // Tambahkan rute /home
        '/Home': (context) => Home(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/Home') {
          // Ensure user is logged in before navigating to Home
          if (FirebaseAuth.instance.currentUser != null) {
            return MaterialPageRoute(builder: (context) => Home());
          } else {
            // Redirect to Login if user is not logged in
            return MaterialPageRoute(builder: (context) => Login());
          }
        }
        return null; // Return null for any other routes
      },
    );
  }
}
