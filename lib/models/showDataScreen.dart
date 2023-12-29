// display_data_page.dart

// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/widget.dart';

class DisplayDataPage extends StatefulWidget {
  // final List<Map<String, dynamic>> data;

  DisplayDataPage({super.key});

  @override
  State<DisplayDataPage> createState() => _DisplayDataPageState();
}

class _DisplayDataPageState extends State<DisplayDataPage> {
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
              .collection('lost_items')
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
// Container(
// height: MediaQuery.of(context).size.height,
// child: GridView.builder(
// scrollDirection: Axis.vertical,
// // padding: EdgeInsets.only(left: 5,right: 5,top: 5),
// //           padding: EdgeInsets.only(horizontal: 5,vertical: 5),
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// // Number of columns
// crossAxisSpacing: 3.0,
// // Spacing between columns
// mainAxisSpacing: 3.0,
// // Spacing between rows
// childAspectRatio: 0.6),
// itemCount: snapshot.data!.docs.length,
// // Number of items
// itemBuilder: (context, index) {
// var item = snapshot.data!.docs[index];
// return Container(
// margin:
// EdgeInsets.symmetric(horizontal: 5, vertical: 5),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// item['image_url'] != null
// ? Image.network(
// item['image_url'],
// height: 140,
// width: 200,
// fit: BoxFit.fill,
// )
//     : Container(),
// SizedBox(height: 4),
// Text(
// "Title: ${item['title']}",
// style:
// Theme.of(context).textTheme.displayMedium,
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// ),
// SizedBox(height: 4),
// Text(
// "Description: ${item['description']}",
// style:
// Theme.of(context).textTheme.displayMedium,
// overflow: TextOverflow.ellipsis,
// maxLines: 6,
// ),
// SizedBox(height: 4),
// Text(
// "Location: ${item['location']}",
// style:
// Theme.of(context).textTheme.displayMedium,
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// ),
// SizedBox(height: 4),
// Text(
// "Identity: ${item['identity']}",
// style:
// Theme.of(context).textTheme.displayMedium,
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// ),
// SizedBox(height: 4),
// Text(
// "Date and Time: ${item['date_time'] != null ? item['date_time'] : 'Not available'}",
// style:
// Theme.of(context).textTheme.displayMedium,
// overflow: TextOverflow.ellipsis,
// maxLines: 1,
// ),
// ],
// ),
// );
//
// })
