import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//funcion que nos regrese una lista de strings
Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection('people');

  //query para obtener lista de bd
  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  //se hace for each para iterar todos los datos e ir agregando cada uno a la lista
  queryPeople.docs.forEach((documento) {
    people.add(documento.data());
  });

  return people;
}
