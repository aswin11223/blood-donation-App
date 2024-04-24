import 'package:flutter/material.dart';
import 'package:flutter_blooddonation_19/screens/home.dart';
import 'package:flutter_blooddonation_19/screens/update.dart';
import './Add_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "blooddonation",
      routes: {
        '/':(context) => Homepage(),
        '/Adduser':(context) => Adduser(),
        '/updateuser':(context)=>Update()
      },
      initialRoute: '/',
    );
  }
}