import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:udemy_lessons/widgets/user_image_picker_widget.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _haveAuth = true;
  var _isAuthenticating = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _profilePicture;

  void _submitImage(UserCredential userCredential) async {
    if (!_haveAuth && _profilePicture == null) {
      return;
    }
    try {
      final imageStorage = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredential.user!.uid}.jgp');
      await imageStorage.putFile(_profilePicture!);
      // final imageUrl = await imageStorage.getDownloadURL();
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Image Upload failed: $error',
          ),
        ),
      );
    }
  }

  void _submitEmailPassword() async {
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_haveAuth) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        final userCredentials =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        _submitImage(userCredentials);
      }
      setState(() {
        _isAuthenticating = false;
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ......
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Authentication failed',
          ),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    _submitEmailPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_haveAuth)
                            UserImagePickerWidget(
                              onPickImage: (pickedImage) {
                                _profilePicture = pickedImage;
                              },
                            ),
                          _emailTextFormField(),
                          _passwordTextFormField(),
                          const SizedBox(
                            height: 20,
                          ),
                          _isAuthenticating
                              ? const CircularProgressIndicator()
                              : _submitElevatedButton(context),
                          _askMembershipSwitch(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _submitElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Text(_haveAuth ? 'Sing IN' : 'Sing UP'),
    );
  }

  Row _askMembershipSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Have a account?'),
        Switch(
          value: _haveAuth,
          onChanged: (value) {
            setState(() {
              _haveAuth = value;
            });
          },
        ),
      ],
    );
  }

  TextFormField _passwordTextFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.trim().isEmpty || value.trim().length < 6) {
          return 'Invalid password given';
        }
        return null;
      },
    );
  }

  TextFormField _emailTextFormField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email Address',
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value == null || value.trim().isEmpty || !value.contains('@')) {
          return 'Invalid email given';
        }
        return null;
      },
    );
  }
}
