import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/repeated_button_widget.dart';

const textColor = [
  Colors.purpleAccent,
  Colors.yellowAccent,
  Colors.blueAccent,
  Colors.green,
  Colors.red,
  Colors.teal
];
const textStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Acme');

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool processing = false;
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection("anonymous");
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/inapp/bgimage.jpg'),
                fit: BoxFit.cover)),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'WELCOME',
                    textStyle: textStyle,
                    colors: textColor,
                  ),
                  ColorizeAnimatedText(
                    'TechSpace Store',
                    textStyle: textStyle,
                    colors: textColor,
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),

              /* const Text(
                'WELCOME',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ), */
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(
                  image: AssetImage('images/inapp/logo.jpg'),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acme'),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Buy'),
                      RotateAnimatedText('Shop'),
                      RotateAnimatedText('TechSpace Store'),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                ),
              ),
              /* const Text(
                'SHOP',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ), */
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Suppliers Only',
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedLogo(controller: _controller),
                            RepeatedButton(
                              label: 'Log In',
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/supplierLogin_screen');
                              },
                              width: 0.25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: RepeatedButton(
                                label: 'Sign Up',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/supplierSignup_screen');
                                },
                                width: 0.25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RepeatedButton(
                            label: 'Log In',
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/customerLogin_screen');
                            },
                            width: 0.25,
                          ),
                        ),
                        RepeatedButton(
                          label: 'Sign Up',
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/customerSignup_screen');
                          },
                          width: 0.25,
                        ),
                        AnimatedLogo(controller: _controller),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white38.withOpacity(0.3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SocialMediaButtons(
                        onPressed: () {},
                        label: 'Google',
                        child: const Image(
                            image: AssetImage('images/inapp/google.jpg')),
                      ),
                      SocialMediaButtons(
                        onPressed: () {},
                        label: 'Facebook',
                        child: const Image(
                            image: AssetImage('images/inapp/facebook.jpg')),
                      ),
                      processing == true
                          ? const CircularProgressIndicator()
                          : SocialMediaButtons(
                              onPressed: () async {
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .whenComplete(() async {
                                  _uid = FirebaseAuth.instance.currentUser!.uid;
                                  await anonymous.doc(_uid).set({
                                    'name': '',
                                    'email': '',
                                    'profileimage': '',
                                    'phone': '',
                                    'address': '',
                                    'cid': _uid,
                                  });
                                });

                                setState(() {
                                  processing = true;
                                });
                                await Future.delayed(const Duration(microseconds: 100)).whenComplete(() =>Navigator.pushReplacementNamed(
                                    context, '/customer_home') );
                                
                              },
                              label: 'Guest',
                              child: const Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.lightBlueAccent,
                              ),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      animation: _controller.view,
      child: const Image(image: AssetImage('images/inapp/logo.jpg')),
    );
  }
}

class SocialMediaButtons extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const SocialMediaButtons({
    super.key,
    required this.label,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
