import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddApartmentsPage extends StatefulWidget {
  const AddApartmentsPage({super.key});

  @override
  State<AddApartmentsPage> createState() => _AddApartmentsPageState();
}

class _AddApartmentsPageState extends State<AddApartmentsPage> {
  String apartmentName = '';
  String houseType = '';
  String houseNumber = '';
  String rent = '';
  String rentDueDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Apartment Details'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.apartment, color: Colors.black),
            title: Text('Apartment Name: $apartmentName'),
          ),
          ListTile(
            leading: const Icon(Icons.house, color: Colors.black),
            title: Text('House Type: $houseType'),
          ),
          ListTile(
            leading: const Icon(Icons.house, color: Colors.black),
            title: Text('Number of Houses: $houseNumber'),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.black),
            title: Text('Rent: $rent ksh per month'),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.black),
            title: Text('Rent Due Date: $rentDueDate'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApartmentFormPage(
                    apartmentName: apartmentName,
                    houseType: houseType,
                    houseNumber: houseNumber,
                    rent: rent,
                    rentDueDate: rentDueDate,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  apartmentName = result['apartmentName'];
                  houseType = result['houseType'];
                  houseNumber = result['houseNumber'];
                  rent = result['rent'];
                  rentDueDate = result['rentDueDate'];
                });
              }
            },
            child: const Text('Add/Edit Apartment Details'),
          ),
        ],
      ),
    );
  }
}

class ApartmentFormPage extends StatefulWidget {
  final String apartmentName;
  final String houseType;
  final String houseNumber;
  final String rent;
  final String rentDueDate;

  const ApartmentFormPage({super.key, 
    required this.apartmentName,
    required this.houseType,
    required this.houseNumber,
    required this.rent,
    required this.rentDueDate,
  });

  @override
  _ApartmentFormPageState createState() => _ApartmentFormPageState();
}

class _ApartmentFormPageState extends State<ApartmentFormPage> {
  final TextEditingController apartmentNameController = TextEditingController();
  final TextEditingController houseTypeController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController rentDueDateController = TextEditingController();
  List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    apartmentNameController.text = widget.apartmentName;
    houseTypeController.text = widget.houseType;
    houseNumberController.text = widget.houseNumber;
    rentController.text = widget.rent;
    rentDueDateController.text = widget.rentDueDate;
  }

  @override
  void dispose() {
    apartmentNameController.dispose();
    houseTypeController.dispose();
    houseNumberController.dispose();
    rentController.dispose();
    rentDueDateController.dispose();
    super.dispose();
  }

  Future pickImagesGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    setState(() {
      _selectedImages = pickedImages.map((e) => File(e.path)).toList();
    });
  }

  Future pickImageCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      _selectedImages.add(File(pickedImage.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apartment Details Form'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTextField("Apartment Name", apartmentNameController,
              "Enter Apartment Name"),
          _buildTextField(
              "House Type", houseTypeController, "Enter House Type"),
          _buildTextField("Number of Houses", houseNumberController,
              "Enter Number of Houses"),
          _buildTextField("Rent", rentController, "Enter Rent"),
          _buildTextField(
              "Rent Due Date", rentDueDateController, "Enter Rent Due Date"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Apartment Pictures"),
                MaterialButton(
                  color: Colors.teal,
                  onPressed: pickImagesGallery,
                  child: const Text(
                    "Pick images from gallery",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                    : const Text("Please select images"),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'apartmentName': apartmentNameController.text,
                'houseType': houseTypeController.text,
                'houseNumber': houseNumberController.text,
                'rent': rentController.text,
                'rentDueDate': rentDueDateController.text,
              });
            },
            child: const Text('Save Details'),
          ),
        ],
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
              hintStyle:
                  const TextStyle(color: Colors.grey), // Uniform placeholder color
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
      home: const AddApartmentsPage(),
    ));
