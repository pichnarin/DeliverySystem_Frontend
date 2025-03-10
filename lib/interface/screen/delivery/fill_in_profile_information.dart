import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:frontend/interface/component/widgets/text_button.dart';
import 'package:frontend/interface/component/widgets/dropdown.dart';
import 'package:frontend/interface/component/widgets/textfield.dart';
import 'package:frontend/interface/screen/delivery/registration_page.dart';
import 'package:frontend/interface/theme/theme.dart';
import 'package:image_picker/image_picker.dart';

class FillInProfileInfo extends StatefulWidget {
  const FillInProfileInfo({super.key});

  @override
  State<FillInProfileInfo> createState() => _FillInProfileInfoState();
}

class _FillInProfileInfoState extends State<FillInProfileInfo> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender = 'Male';
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery, 
    );

    if (pickedFile != null) {
      print("Image selected: ${pickedFile.path}");
      setState(() {
        _image = File(pickedFile.path); 
      });
    }else {
    print("No image selected");
  }
  }
  
   // Function to show date picker and update controller
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fill Your Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                    ? FileImage(_image!) as ImageProvider
                    : const AssetImage('assets/images/user1.png'),
                    child: _image == null ? const Icon(Icons.camera_alt, size: 40) : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              ReusableTextField(
                controller: _userNameController,
                hintText: "Username",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: _dobController,
                hintText: "Date of Birth",
                onTap: () => _selectDate(context),
                suffixIcon: GestureDetector(
                  onTap: () => _selectDate(context),  
                  child: const Icon(Icons.calendar_month),
                ),
                            ),
              const SizedBox(height: 10),
              ReusableDropdown(
                hintText: 'Select Gender',
                items: const ['Male', 'Female', 'Other'], 
                selectedValue: _selectedGender, 
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value; 
                  });
                },
              ),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: _phoneNumberController,
                hintText: "Phone Number",
              ),
              const SizedBox(height: 50), 
              Center(
                child: CustomButton(
                  buttonText: 'Continue', 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegistrationPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}