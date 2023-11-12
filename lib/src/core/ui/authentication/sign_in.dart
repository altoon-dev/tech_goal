import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_goal/src/core/styles/formatter.dart';
import 'package:tech_goal/src/core/ui/authentication/widgets/custom_elevated_button.dart';
import 'package:tech_goal/src/core/ui/authentication/widgets/custom_text_form_field.dart';
import 'package:tech_goal/src/core/ui/welcome/welcome_eugene.dart';
import 'dart:io';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _passwordVisible = true;
  final birthDateController = TextEditingController();
  final nicknameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                CustomTextFormField(
                  hintText: "Nickname",
                  controller: nicknameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Zа-яА-Я]"))
                  ],
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Enter Nickname';
                    }
                    if (name.length < 3) {
                      return 'Enter at least 3 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  obscureText: !_passwordVisible,
                  hintText: "Password",
                  controller: passwordController,
                  suffixIcon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onSuffixIconPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Enter password';
                    }
                    if (password.length < 6) {
                      return 'Enter at least 6 symbols';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: "Birth Date",
                  controller: birthDateController,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [dateMaskFormatter],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter the date';
                    }
                    final parts = value.split('.');
                    if (parts.length != 3) {
                      return 'Incorrect date format';
                    }
                    final day = int.tryParse(parts[0]);
                    final month = int.tryParse(parts[1]);
                    final year = int.tryParse(parts[2]);
                    if (day == null || month == null || year == null) {
                      return 'Incorrect date format';
                    }
                    if (day > 31 || day < 1) {
                      return 'Incorrect day';
                    }
                    if (month > 12 || month < 1) {
                      return 'Incorrect month';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  hintText: "Phone number",
                  controller: phoneNumberController,
                  inputFormatters: [maskFormatter],
                  validator: (password) {
                    if (password!.isEmpty) {
                      return 'Enter password';
                    }
                    if (password.length < 11) {
                      return 'Enter at least 11 symbols';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: CustomElevatedButton(
                    text: 'Upload Avatar',
                    onPressed: _pickImage,
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(File(_imageFile!.path))
                      : const AssetImage('assets/images/kerek.jpg') as ImageProvider<Object>,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: CustomElevatedButton(
                    onPressed: _signIn,
                    text: 'Sign in',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeEugene()),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print('Image picker error: $e');
    }
  }
}
