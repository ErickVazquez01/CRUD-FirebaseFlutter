import 'package:flutter/material.dart';
import 'package:residuosapp_v1/services/firebase_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
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
        title: const Text('CRUD - Firebase'),
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (((context, snapshot) {
          if (snapshot.hasData) {
            //verifica que haya lista ya que puede dar error por milisegundos
            return ListView.builder(
              itemCount: snapshot.data?.length, //creacion de array interno
              itemBuilder: (context, index) {
                //dismisible hace que se pueda desplazar horizontalmente
                return Dismissible(
                  //se ejecuta cuando el elemento desaparece y borra en bd
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]['uid']);
                    //sirve para borrar el dato del array interno
                    snapshot.data?.removeAt(index);
                  },
                  //ayuda a confirmar el lado del deslizamiento true lo hace, false no
                  confirmDismiss: (direction) async {
                    bool result = false;

                    result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                "Estas seguro que quieres eliminar a ${snapshot.data?[index]['name']}"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    //navigator.pop cierra ventana y regresa valor
                                    //se almacena en result
                                    return Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancelar",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 175, 76, 76)))),
                              TextButton(
                                  onPressed: () {
                                    return Navigator.pop(context, true);
                                  },
                                  child: Text("Si, estoy seguro"))
                            ],
                          );
                        });

                    return result;
                  },
                  background: Container(
                    //color que saldrá de fondo al mover un elemento
                    color: Colors.red,
                    /*forma de acomodar icono del lado derecho*/
                    child: Center(
                      child: Container(
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                  //hace que solo se deslice hacia al derecha
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    onTap: (() async {
                      await Navigator.pushNamed(context, "/edit", arguments: {
                        "name": snapshot.data?[index]['name'],
                        "uid": snapshot.data?[index]['uid'],
                      });
                      setState(() {
                        //para actualizar la ventana al ser regresado
                        //va junto con async y await del onTap
                      });
                    }),
                  ),
                );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //se hace asincrono para que se actualice al agregar datos
          await Navigator.pushNamed(context, '/add');
          setState(() {
            //se actualiza los datos
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
