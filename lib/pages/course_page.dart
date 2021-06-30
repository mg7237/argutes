import 'package:smart_argutes/pages/purchase_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class purchasePage extends StatefulWidget {
  @override
  _purchasePageState createState() => _purchasePageState();
}

class _purchasePageState extends State<purchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('appleUserCourse')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final document = snapshot.data!.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: document.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Purchase(
                                        subject: document[index]['subject'],
                                        cost: document[index]['cost']),
                                  ),
                                );
                              },
                              child: Container(
                                height: 150,
                                width: 300,
                                child: Card(
                                  elevation: 20,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Subject: ${document[index]['subject']}'),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'cost: ${document[index]['cost']}/-'),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'valid till: ${document[index]['valid']}'),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        Text(
                                          'Buy Now',
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
