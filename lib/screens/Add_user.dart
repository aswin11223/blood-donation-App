

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Adduser extends StatefulWidget {
  const Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
final bloodgroups=['A+','A-','B+','B-','O+','0-','AB+'];
final CollectionReference donor=FirebaseFirestore.instance.collection('Donor');
TextEditingController name_controller=TextEditingController();
TextEditingController phoneno_controller=TextEditingController();


void adddoner(){
  final    data= {
    'name':name_controller.text,
    'phoneno':phoneno_controller.text,
    'bloodgroup':selectedbloodgroup!,

  };
  donor.add(data);


}

String ?selectedbloodgroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add User",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body:  Column(
        children: [
           Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: name_controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),label: Text("DonorName")
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: phoneno_controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),label: Text("PhoneNo")
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                hintText: "BloodGroups"
              ),
              
              items:bloodgroups.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(), onChanged: (val){
              selectedbloodgroup=val;
            }),
          ),
          ElevatedButton(onPressed: (){
          adddoner();
          Navigator.pop(context);
          }, 
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
            backgroundColor: MaterialStateProperty.all(Colors.black)
          ),
          
          
          child: Text("ADD",style: TextStyle(color: Colors.white,fontSize: 20),))
        ],
      ),
    );
  }
}
