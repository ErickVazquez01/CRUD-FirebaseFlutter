import 'package:flutter/material.dart';

//importaciones firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:residuosapp_v1/pages/edit_name_page.dart';
import 'firebase_options.dart';

//sistema de rutas
import 'package:residuosapp_v1/pages/add_name_page.dart';
import 'package:residuosapp_v1/pages/home_page.dart';

void main() async {
  //inicializador a firebase en aplicación
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(), //sistema de rutas (clave, valor)
        '/add': (context) => const AddNamePage(),
        '/edit': (context) => const EditNamePage(),
      },
    );
  }
}
