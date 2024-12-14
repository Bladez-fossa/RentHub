import 'package:flutter/material.dart';

class TenantFormScreen extends StatefulWidget {
  final String apartmentName;
  final String rentDueDate;
  final String rent;
  final String houseNumber;
  final String houseType;

  const TenantFormScreen({super.key, 
    this.apartmentName = '',
    this.rentDueDate = '1st of every month',
    this.rent = '',
    this.houseNumber = '',
    this.houseType = '',
  });

  @override
  _TenantFormScreenState createState() => _TenantFormScreenState();
}

class _TenantFormScreenState extends State<TenantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _apartmentNameController;
  late TextEditingController _rentDueDateController;
  late TextEditingController _rentController;
  late TextEditingController _houseNumberController;
  late TextEditingController _houseTypeController;
  String? _selectedHouseType;
  bool _isOtherSelected = false;

  @override
  void initState() {
    super.initState();
    _apartmentNameController =
        TextEditingController(text: widget.apartmentName);
    _rentDueDateController = TextEditingController(text: widget.rentDueDate);
    _rentController = TextEditingController(text: widget.rent);
    _houseNumberController = TextEditingController(text: widget.houseNumber);
    _houseTypeController = TextEditingController(text: widget.houseType);
  }

  @override
  void dispose() {
    _apartmentNameController.dispose();
    _rentDueDateController.dispose();
    _rentController.dispose();
    _houseNumberController.dispose();
    _houseTypeController.dispose();
    super.dispose();
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'apartmentName': _apartmentNameController.text,
        'rentDueDate': _rentDueDateController.text,
        'rent': _rentController.text,
        'houseNumber': _houseNumberController.text,
        'houseType':
            _isOtherSelected ? _houseTypeController.text : _selectedHouseType,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // handle menu action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://example.com/avatar.jpg'), // Placeholder image
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _apartmentNameController,
                  decoration: const InputDecoration(
                    labelText: 'Apartment Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter apartment name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedHouseType,
                  items: [
                    'Single room',
                    'Bedsitter',
                    '1 bedroom',
                    'Two bedroom',
                    'Other'
                  ]
                      .map((type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedHouseType = value;
                      _isOtherSelected = value == 'Other';
                      if (!_isOtherSelected) {
                        _houseTypeController.clear();
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'House Type',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a house type';
                    }
                    return null;
                  },
                ),
                if (_isOtherSelected) const SizedBox(height: 16),
                if (_isOtherSelected)
                  TextFormField(
                    controller: _houseTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Please specify',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter house type';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _houseNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Number of Houses',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of houses';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _rentController,
                  decoration: const InputDecoration(
                    labelText: 'Rent',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rent amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _rentDueDateController,
                  decoration: const InputDecoration(
                    labelText: 'Rent Due Date',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rent due date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // handle picture upload
                  },
                  child: const Text('Upload Apartment Picture'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveDetails,
                  child: const Text('Save Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
