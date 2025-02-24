import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'package:firebase_messaging/firebase_messaging.dart'; // Importa Firebase Messaging
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';

// Manejo de notificaciones en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Notificación recibida en segundo plano: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para inicializar Firebase y SharedPreferences

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Configura el manejo de notificaciones en segundo plano
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Verifica si la sesión está activa
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Verifica si la sesión está activa

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: isLoggedIn ? HomeScreen() : SplashScreen(), // Redirige según el estado de la sesión
    );
  }
}