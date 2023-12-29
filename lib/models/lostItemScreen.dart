import 'dart:io';

import 'package:find_lost_app/models/showDataScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import '../widget/widget.dart';

class LostItemPageScreen extends StatefulWidget {
  const LostItemPageScreen({super.key});

  @override
  State<LostItemPageScreen> createState() => _LostItemPageScreenState();
}

class _LostItemPageScreenState extends State<LostItemPageScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _identity = "";
  String _location = '';
  String imageUrl = '';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat.jm().format(dateTime);
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    }

    setState(() {
      imageUrl = pickedFile.path;
    });
  }

  Future<void> _getImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return;
    }

    setState(() {
      imageUrl = pickedFile.path;
    });
  }

  Future<void> saveDataToFirestore() async {
    try {
      setState(() {});
      // Upload image to Firebase Storage
      String imageUrl = await uploadImageToStorage();
      String formattedDateTime = _selectedDate != null
          ? DateFormat('yyyy-MM-dd HH:mm a').format(_selectedDate!)
          : '';
      // Save data to Firestore
      DocumentReference documentReference =
          await FirebaseFirestore.instance.collection('lost_items').add({
        'title': _title,
        'description': _description,
        'location': _location,
        'image_url': imageUrl,
        'identity': _identity, // Add identity
        'date_time': formattedDateTime,
        // Use a new field for date and time// Add date

        // 'document_id': '',// Placeholder for the document ID
      });

      // Access the ID of the added document
      String documentId = documentReference.id;

      // Update the document with the actual document ID
      await documentReference.update({'document_id': documentId});
      print('Document added with ID: $documentId');
      showToast(message: 'Upload Successfully!');
    } catch (e) {
      showToast(message: 'Error saving data to Firestore: $e');
      // Handle the error appropriately.
    }
  }

  Future<String> uploadImageToStorage() async {
    try {
      // Create a reference to the Firebase Storage location
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('storeImages/${DateTime.now().millisecondsSinceEpoch}');

      // Upload the file to Firebase Storage
      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(File(imageUrl));

      // Wait for the upload to complete and get the download URL
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      showToast(message: 'Error uploading image to Firebase Storage: $e');
      // Handle the error appropriately.
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            25, 25, 25, MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // // Display selected image
                imageUrl.isNotEmpty
                    ? Image.file(
                        File(imageUrl),
                        height: 130,
                        width: 200,
                        fit: BoxFit.fill,
                      )
                    : Container(),

                const SizedBox(
                  height: 20,
                ), // Placeholder if no image is selected
                // Conditionally display the buttons
                imageUrl.isEmpty
                    ? RoundedButtons(
                        onPressed: () async {
                          await _getImageCamera();
                        },
                        child: Text('TAKE A PHOTO',
                            style: Theme.of(context).textTheme.displayLarge),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                imageUrl.isEmpty
                    ? RoundedButtons(
                        onPressed: () async {
                          await _getImageGallery();
                        },
                        child: Text('UPLOAD AN IMAGE',
                            style: Theme.of(context).textTheme.displayLarge),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                // Rest of your code...

                GetTextFormField(
                  maxlines: 1,
                  // controller: titleController,
                  labelText: "Title",
                  hintText: "Enter the title",
                  prefixIcon: const Icon(
                    Icons.title,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.name,
                  toolbarOptions: const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  onChanged: (Value) {
                    setState(() {
                      _title = Value;
                    });
                  },

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GetTextFormField(
                  maxlines: 3,
                  // controller: descriptionController,
                  labelText: "Description",
                  hintText: "Enter the Description",
                  prefixIcon:
                      const Icon(Icons.description, color: Colors.black),
                  keyboardType: TextInputType.name,
                  toolbarOptions: const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  onChanged: (Value) {
                    setState(() {
                      _description = Value;
                    });
                  },

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GetTextFormField(
                  maxlines: 1,
                  labelText: "Identity",
                  hintText: "Enter the Identity",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.text,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _identity = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter identity';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GetTextFormField(
                  maxlines: 1,
                  labelText: "Location",
                  hintText: "Enter the Location",
                  prefixIcon:
                      const Icon(Icons.location_city, color: Colors.black),
                  keyboardType: TextInputType.name,
                  toolbarOptions: const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  onChanged: (Value) {
                    setState(() {
                      _location = Value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GetTextFormField(
                  maxlines: 1,
                  labelText: "Date and Time",
                  hintText: "Select the Date and Time",
                  prefixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.text,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (selectedDate != null) {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        setState(() {
                          _selectedDate = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        });
                      }
                    }
                  },
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd hh:mm a')
                            .format(_selectedDate!)
                        : '',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please select date and time';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                RoundedButtons(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (imageUrl.isNotEmpty) {
                          await saveDataToFirestore();
                          Navigator.pop(context);
                        } else {
                          showToast(message: "Error getting user identity");
                        }
                      } else {
                        showToast(message: "Error Failed");
                      }
                  },
                  child: Text('Add',
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

