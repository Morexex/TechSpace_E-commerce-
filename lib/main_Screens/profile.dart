import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens/customer_orders.dart';
import 'package:multi_store_app/customer_screens/wishlist.dart';
import 'package:multi_store_app/main_Screens/cart.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

import '../widgets/alert_dialogue.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({super.key, required this.documentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
      CollectionReference anonymous=
      FirebaseFirestore.instance.collection('anonymous');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous?anonymous.doc(widget.documentId).get() :customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong!");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist!");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return //Text("Full Name: ${data['full_name']} ${data['full_name']}");

              Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Stack(
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.black54],
                    ),
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      pinned: true,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      expandedHeight: 120,
                      flexibleSpace:
                          LayoutBuilder(builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: constraints.biggest.height <= 120 ? 1 : 0,
                            child: const Text(
                              'Account',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          background: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.yellow, Colors.black54],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25, left: 30),
                              child: Row(
                                children: [
                                  data['profileimage'] == ''? const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('images/inapp/guest.jpg'),
                                  ):
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(data['profileimage']),
                                  ),
                                  /* const Padding(
                              padding: EdgeInsets.only(top: 25, left: 30),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('images/inapp/guest.jpg'),
                              ),
                                                      ), */
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      data['name'] == ''
                                          ? 'guest'.toUpperCase()
                                          : data['name'].toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30))),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 65,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const Center(
                                        child: Text(
                                          ' Cart',
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 24),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CartScreen(
                                                    back: AppBarBackButton(),
                                                  )));
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.purple,
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 65,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const Center(
                                        child: Text(
                                          ' Orders',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CustomerOrdersScreen()));
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: TextButton(
                                    child: SizedBox(
                                      height: 65,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const Center(
                                        child: Text(
                                          ' WishList',
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WishListScreen()));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 180,
                                  child: Image(
                                      image:
                                          AssetImage('images/inapp/logo.jpg')),
                                ),
                                const ProfileHeaderLabel(
                                  headerLabel: '  Account Info  ',
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Column(
                                      children: [
                                        RepeatedListTile(
                                          title: 'Email Address',
                                          subTitle:data['email']==''? 'emaple@gmail.com': data['email'],
                                          icon: Icons.email,
                                        ),
                                        const PurpleDivider(),
                                        RepeatedListTile(
                                          title: 'Phone Number',
                                          subTitle:data['phone']==''? 'example+2547xxxxxxxx': data['phone'],
                                          icon: Icons.phone,
                                        ),
                                        const PurpleDivider(),
                                        RepeatedListTile(
                                          title: 'Address',
                                          subTitle: data['address']==''? 'example@kangaru-Embu': data['address'],
                                          icon: Icons.location_pin,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const ProfileHeaderLabel(
                                    headerLabel: ' Account Setting '),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Column(
                                      children: [
                                        RepeatedListTile(
                                          title: 'Edit Profile',
                                          subTitle: '',
                                          icon: Icons.edit,
                                          onPressed: () {},
                                        ),
                                        const PurpleDivider(),
                                        RepeatedListTile(
                                          title: 'Change Password',
                                          icon: Icons.lock,
                                          onPressed: () {},
                                        ),
                                        const PurpleDivider(),
                                        RepeatedListTile(
                                          title: 'Log Out',
                                          icon: Icons.logout,
                                          onPressed: () async {
                                            MyAlertDialogue.showMyDialogue(
                                                context: context,
                                                title: 'Log Out',
                                                content:
                                                    'Are you sure you want to log out?',
                                                tabNo: () {
                                                  () {
                                                    Navigator.pop(context);
                                                  };
                                                },
                                                tabYes: () async {
                                                  await FirebaseAuth
                                                      .instance.signOut;
                                                  Navigator.pop(context);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          '/welcome_screen');
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.yellow,
          ),
        );
      },
    );
  }
}

class PurpleDivider extends StatelessWidget {
  const PurpleDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.purple,
        thickness: 2,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListTile({
    super.key,
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({
    super.key,
    required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          headerLabel,
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}
