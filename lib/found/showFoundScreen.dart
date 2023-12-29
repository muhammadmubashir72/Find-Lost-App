// display_data_page.dart

// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/widget.dart';

class FoundDataPage extends StatefulWidget {
  // final List<Map<String, dynamic>> data;

  FoundDataPage({super.key});

  @override
  State<FoundDataPage> createState() => _FoundDataPageState();
}

class _FoundDataPageState extends State<FoundDataPage> {
  TextEditingController searchController = TextEditingController();

  String search = "";
  List<String> areaFound = [
    'IT-101',
    'IT-102',
    'IT-103',
    'IT-104',
    'IT-105',
    'IT-201',
    'IT-202',
    'IT-203',
    'IT-204',
    'IT-205',
    'IT-301',
    'IT-302',
    'IT-303',
    'IT-304',
    'IT-305',
    'IT-401',
    'IT-402',
    'IT-403',
    'IT-404',
    'IT-405',
    'IT-501',
    'IT-502',
    'IT-503',
    'IT-504',
    'IT-505',
    "Talpur House",
    "Media",
    "Lab-101",
    "Lab-102",
    "Lab-103",
    "Lab-104",
    "Lab-105",
    "Lab-201",
    "Lab-202",
    "Lab-203",
    "Lab-204",
    "Lab-205",
    "Lab-301",
    "Lab-302",
    "Lab-303",
    "Lab-304",
    "Lab-405",
    "Lab-501",
    "Lab-502",
    "Lab-503",
    "Lab-504",
    "Lab-505",
  ];
  List<String> admin = [
    "Sir Ameen",
    "Sir Sajjad",
    "Sir Hafeez",
    "Sir Zubair",
    "Sir Zeeshan"
  ];

  @override
  Widget build(BuildContext context) {
    admin.shuffle();
    areaFound.shuffle();

    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     // Handle back button press
          //     Navigator.of(context).pop();
          //   },
          // ),
            actions: [
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 7),
                width: 330,
                child: GetTextFormField(
                  maxlines: 1,
                  labelText: "Search",
                  hintText: "Enter the Search",
                  controller: searchController,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.name,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  onChanged: (Value) {
                    setState(() {
                      search = Value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
              ),
            ]),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('found_items')
              .where('identity', isEqualTo: search)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  String randomArea = areaFound[index % areaFound.length];
                  String randomAdmin = admin[index % admin.length];

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            documents[index]['image_url'],
                            width: double.maxFinite,
                            height: 200,
                          ),
                          Text(documents[index]['title'],style: Theme.of(context).textTheme.titleMedium,),
                          Text(documents[index]['description'],style: Theme.of(context).textTheme.titleMedium,),
                          Text(documents[index]['location'],style: Theme.of(context).textTheme.titleMedium,),
                          Text("Found from $randomArea By $randomAdmin",style: Theme.of(context).textTheme.titleMedium,),
                          Text(documents[index]['date_time'],style: Theme.of(context).textTheme.titleMedium,),

                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
