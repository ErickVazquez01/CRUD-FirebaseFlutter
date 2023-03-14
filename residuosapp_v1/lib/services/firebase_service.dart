import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//funcion que nos regrese una lista de strings
Future<List> getPeople() async {
  List people = [];
  //CollectionReference collectionReferencePeople = db.collection('people');

  //query para obtener lista de bd
  QuerySnapshot querySnapshot = await db.collection('people').get();
  //se hace for each para iterar todos los datos e ir agregando cada uno a la lista
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name": data['name'],
      "uid": doc.id,
    };
    people.add(person);
  }

  return people;
}

//guardar en bd firebase
Future<void> addPeople(String name) async {
  await db.collection("people").add({"name": name});
}

//actualizar name en bd
Future<void> updatePeople(String uid, String newName) async {
  await db.collection("people").doc(uid).set({"name": newName});
}

//eliminar datos de firebase
Future<void> deletePeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}
