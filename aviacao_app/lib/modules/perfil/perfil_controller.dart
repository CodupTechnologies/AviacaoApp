import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// doc users is used in this case
final _user = FirebaseAuth.instance.currentUser!.uid.toString();

Future SetUserData(String UserFirstName, String UserLastName, String UserCRM,
    String UserBirthday, String UserWhatsapp, String UserEmail) async {
  await FirebaseFirestore.instance.collection('users').doc(_user).set({
    'UserFirstName': UserFirstName,
    'UserLastName': UserLastName,
    'UserCRM': UserCRM,
    'UserBirthday': UserBirthday,
    'UserWhatsapp': UserWhatsapp,
    'UserEmail': UserEmail,
    'UserEnable': true,
  }).then((res) => print("Dados atualizados com sucesso"),
      onError: (e) => print("Erro na atualização"));
}

Future ShowUserData() async {
  var userData;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(_user)
      .get()
      .then((DocumentSnapshot doc) {
    userData = doc.data() as Map<String, dynamic>;
  });
  return userData;
}
