import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final TextEditingController meinControl = TextEditingController();
  final TextEditingController controll = TextEditingController();
  final TextEditingController myControl = TextEditingController();
  final TextEditingController mController = TextEditingController();
  final TextEditingController meControl = TextEditingController();
  final TextEditingController neControl = TextEditingController();
  List<File> _selectedImages =
      []; // used to hold the selected images from gallery

  // The method to pick multiple images from the gallery.
  Future pickImagesGallery() async {
    final pickedImages =
        await ImagePicker().pickMultiImage();
    setState(() {
      _selectedImages = pickedImages.map((e) => File(e.path)).toList();
    });
  }

  // The method to pick an image from the camera.
  Future pickImageCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      _selectedImages.add(File(pickedImage.path));
    });
  }

  @override
  void dispose() {
    meinControl.dispose();
    controll.dispose();
    myControl.dispose();
    mController.dispose();
    meControl.dispose();
    neControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apartment Details Entry"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildTextField(
                  "Apartment Name", meinControl, "Enter Apartment Name"),
              _buildTextField(
                  "Apartment Number", controll, "Enter Apartment Number"),
              _buildTextField(
                  "Apartment Location", neControl, "Enter Apartment Location"),
              _buildTextField("Room Type i.e (1 bedroom, bedsitter)", myControl,
                  "Enter the room type"),
              _buildTextField("Rent per month", mController, "Enter Rent"),
              _buildTextField("Vacant Rooms", meControl,
                  "Enter the number of vacant rooms "),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Apartment pictures"),
                    MaterialButton(
                      color: Colors.teal,
                      onPressed: pickImagesGallery,
                      child: const Text(
                        "Pick images from gallery",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.blueGrey,
                      onPressed: pickImageCamera,
                      child: const Text(
                        "Take image directly from the camera",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _selectedImages.isNotEmpty
                        ? Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: _selectedImages.map((image) {
                              return Image.file(
                                image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                          )
                        : const Text("Please select images")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextField(
      String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
              fillColor: Colors.blueGrey.shade50,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey.shade200,
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.teal.shade900),
          bodyMedium: TextStyle(color: Colors.teal.shade800),
        ),
      ),
      home: const AddDetails(),
    ));
