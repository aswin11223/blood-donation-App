import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('Donor');


  deleteuser(docid){
    donor.doc(docid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Blood Donation App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Adduser');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: donor.orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donarSnap = snapshot.data!.docs[index];
                final Map<String, dynamic>? data = donarSnap.data() as Map<String, dynamic>?;

                final bloodGroup = data?['bloodgroup'] ?? 'N/A';

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 60,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: double.infinity,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Text(
                                bloodGroup,
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data?['name'] ?? '',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data?['phoneno']?.toString() ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/updateuser',
                                arguments: {
                                  'name':data?['name'],
                                  'phoneno':data?['phoneno'],
                                  'bloodgroup':data?['bloodgroup'],
                                  'id':donarSnap.id,
                              }
                                
                                
                                  
                                );
 
                                
                        },
                              icon: Icon(Icons.edit, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                   deleteuser(donarSnap.id);

                              },
                              icon: Icon(Icons.delete, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // If there's no data yet, return a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
