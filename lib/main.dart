
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blooddonation_19/firebase_options.dart';
import 'package:flutter_blooddonation_19/screens/Home_Page.dart';
import 'package:flutter_blooddonation_19/screens/update.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform );
  runApp(Myapp());
}