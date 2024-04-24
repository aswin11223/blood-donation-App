



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
final bloodgroups=['A+','A-','B+','B-','O+','0-','AB+'];
final CollectionReference donor=FirebaseFirestore.instance.collection('Donor');
TextEditingController name_controller=TextEditingController();
TextEditingController phoneno_controller=TextEditingController();

  
  updatedoner(docid){
    final data={
      'name':name_controller.text,
      'phoneno':phoneno_controller.text,
      'bloodgroup':selectedbloodgroup

    };
    donor.doc(docid).update(data).then((value) => Navigator.pop(context));
  }



String ?selectedbloodgroup;

  @override
  Widget build(BuildContext context)
  
   {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
     name_controller.text=args['name'].toString();
      phoneno_controller.text=args['phoneno'].toString();
      selectedbloodgroup=args['bloodgroup'].toString();
      
       final docid=args['id'].toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Update",
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
              value: selectedbloodgroup,
              decoration: const InputDecoration(
                hintText: "BloodGroups"
              ),
              
              items:bloodgroups.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(), onChanged: (val){
              selectedbloodgroup=val;
            }),
          ),
          ElevatedButton(onPressed: (){
            updatedoner(docid);
         
          
          }, 
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 60)),
            backgroundColor: MaterialStateProperty.all(Colors.black)
          ),
          
          
          child: Text("UPDATE",style: TextStyle(color: Colors.white,fontSize: 20),))
        ],
      ),
    );
  }
}
