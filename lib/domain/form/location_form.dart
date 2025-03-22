import 'package:flutter/material.dart';
import '../model/costumer model/LocationItem.dart';
import '../data/district_data.dart';
// import '../../interface/screen/costumer/models/LocationItem.dart';

enum Mode { adding, editing }

class LocationForm extends StatefulWidget {
  final LocationItem? location;
  final Mode mode;

  const LocationForm({super.key, this.location, this.mode = Mode.adding});

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  final _nameController = TextEditingController();
  final _houseNoController = TextEditingController();
  final _streetNoController = TextEditingController();
  final _specificDetailsController = TextEditingController();

  // Dropdown selections
  String? _selectedDistrict;
  String? _selectedVillage;

  @override
  void initState() {
    super.initState();
    if (widget.mode == Mode.editing && widget.location != null) {
      _nameController.text = widget.location!.name;
      _houseNoController.text = widget.location!.houseNo;
      _streetNoController.text = widget.location!.streetNo;
      _specificDetailsController.text = widget.location!.specificDetails;
      _selectedDistrict = widget.location!.district;
      _selectedVillage = widget.location!.village;
    }
  }

  void _saveLocation() {
    final name = _nameController.text;
    final houseNo = _houseNoController.text;
    final streetNo = _streetNoController.text;
    final specificDetails = _specificDetailsController.text;

    if (name.isEmpty || houseNo.isEmpty || streetNo.isEmpty || _selectedDistrict == null || _selectedVillage == null) {
      return;
    }

    final location = LocationItem(
      id: DateTime.now().toString(),
      name: name,
      houseNo: houseNo,
      streetNo: streetNo,
      specificDetails: specificDetails,
      district: _selectedDistrict!,
      village: _selectedVillage!,
    );

    Navigator.of(context).pop(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == Mode.adding ? 'Add Location' : 'Edit Location'),
        actions: [
          IconButton(
            onPressed: _saveLocation,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Location Name'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              decoration: const InputDecoration(labelText: 'District'),
              items: districts.map((district) {
                return DropdownMenuItem<String>(
                  value: district.name,
                  child: Text(district.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDistrict = value;
                  _selectedVillage = null;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedVillage,
              decoration: const InputDecoration(labelText: 'Village'),
              items: _selectedDistrict != null
                  ? districts
                      .firstWhere((district) => district.name == _selectedDistrict)
                      .villages
                      .map((village) {
                        return DropdownMenuItem<String>(
                          value: village,
                          child: Text(village),
                        );
                      }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  _selectedVillage = value;
                });
              },
            ),
            TextField(
              controller: _houseNoController,
              decoration: const InputDecoration(labelText: 'House No'),
            ),
            TextField(
              controller: _streetNoController,
              decoration: const InputDecoration(labelText: 'Street No'),
            ),
            TextField(
              controller: _specificDetailsController,
              decoration: const InputDecoration(labelText: 'Specific Details'),
            ),
          ],
        ),
      ),
    );
  }
}
