import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _haveAuth = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (_haveAuth) {
    } else {
      try {
        _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
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
      }
    }
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
                          _emailTextFormField(),
                          _passwordTextFormField(),
                          const SizedBox(
                            height: 20,
                          ),
                          _submitElevatedButton(context),
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
