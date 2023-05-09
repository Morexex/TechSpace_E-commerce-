// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/auth_repo.dart';
import 'package:multi_store_app/widgets/repeated_button_widget.dart';

import '../widgets/appbar_widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        leading: const AppBarBackButton(),
        title: const AppBarTitle(
          title: 'Reset Password',
        ),
      ),
      body: SafeArea(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'to reset your \n\n please enter your email address \n and click on the purple button bellow',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'acme'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      } else if (!value.isValidEmailAddress()) {
                        return 'invalid email';
                      } else if (value.isValidEmailAddress()) {
                        return null;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: emailFormDecoration.copyWith(
                      labelText: 'Email address',
                      hintText: 'Enter your Email',
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  RepeatedButton(
                      label: 'Send reset password link?',
                      onPressed: () async {
                        if(formKey.currentState!.validate()){
                          AuthRepo.sendPasswordResetEmail(emailController.text);
                        }else{
                          print('form not valid');
                        }
                      },
                      width: 0.7)
                ],
              ),
            )),
      ),
    );
  }
}

var emailFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 1),
      borderRadius: BorderRadius.circular(25)),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
  ),
);

extension EmailValidator on String {
  bool isValidEmailAddress() {
    return RegExp(
            r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
        .hasMatch(this);
  }
}
