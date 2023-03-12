import 'package:flutter/material.dart';

//importaciones firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:residuosapp_v1/services/firebase_service.dart';
import 'firebase_options.dart';

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
    return const MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (((context, snapshot) {
          if (snapshot.hasData) {
            //verifica que haya lista ya que puede dar error por milisegundos
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data?[index]['name']);
              },
            );
          } else {
            //si no hay activa una barra de espera
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        })),
      ),
    );
  }
}
