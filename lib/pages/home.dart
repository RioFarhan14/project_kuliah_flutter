import 'package:flutter/material.dart';
import 'package:project_pi/pages/diagnosis.dart';
import 'package:project_pi/pages/history.dart';
import 'package:project_pi/pages/info.dart';
import 'package:project_pi/pages/login.dart';
import 'package:project_pi/models/button.dart';
import 'package:project_pi/models/sliders.dart';
import 'package:project_pi/widgets/ButtonNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/logo_horizontal.png',
              height: 50,
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Color(0xFF0c999f),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
            },
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 25),
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user?.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      String namaLengkap = data['nama_lengkap'] ?? '';
                      return Text(
                        'Halo, $namaLengkap',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      );
                    } else {
                      return Text(
                        'Halo, Nama Lengkap',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      );
                    }
                  },
                ),
              ),
              Center(
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 30.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Diagnosis()),
                        );
                      },
                      child: ButtonNavigator(
                        button(
                            name: 'Diagnosis Penyakit',
                            ImgUrl: 'assets/diagnosis.png'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Info()),
                        );
                      },
                      child: ButtonNavigator(
                        button(
                            name: 'Informasi Penyakit',
                            ImgUrl: 'assets/info_penyakit.png'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => History()),
                        );
                      },
                      child: ButtonNavigator(
                        button(
                            name: 'Riwayat Penyakit',
                            ImgUrl: 'assets/history.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
