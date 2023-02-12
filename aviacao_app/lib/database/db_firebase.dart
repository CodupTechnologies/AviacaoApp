import 'package:cloud_firestore/cloud_firestore.dart';

class DBFirestore {
  DBFirestore._();

  static final DBFirestore _instance = DBFirestore._();
  final FirebaseFirestore _firestone = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return DBFirestore._instance._firestone;
  }
}
