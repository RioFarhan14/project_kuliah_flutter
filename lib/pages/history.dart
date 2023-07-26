import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_pi/pages/home.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History extends StatelessWidget {
  const History({Key? key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? _currentUser = _auth.currentUser;

    if (_currentUser == null) {
      // User is not logged in, display a login or other view
      return Scaffold(
        body: Center(
          child: Text('User is not logged in'),
        ),
      );
    }

    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final fontSize = isSmallScreen ? 12.0 : 15.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: isSmallScreen ? 650 : 550,
            child: Column(
              children: [
                SizedBox(height: isSmallScreen ? 40 : 60),
                Center(
                  child: Text(
                    'Hasil diagnosis',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallScreen ? 20 : 25,
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 30),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('riwayat_diagnosa')
                      .where('user_id', isEqualTo: _currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No diagnosis history available');
                    }

                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          final waktu =
                              (doc['timestamp'] as Timestamp).toDate();
                          final hasilDiagnosis = doc['hasilpenyakit'];

                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                              Icons.access_alarm), // Clock icon
                                          SizedBox(
                                              width:
                                                  9), // Spacing between icon and text
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Waktu\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: fontSize,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: DateFormat('hh:mm a')
                                                      .format(waktu),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: fontSize,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: isSmallScreen ? 5 : 15),
                                      Row(
                                        children: [
                                          Icon(Icons
                                              .calendar_today), // Calendar icon
                                          SizedBox(
                                              width:
                                                  9), // Spacing between icon and text
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Tanggal\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: fontSize,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: DateFormat('dd/MM/yyyy')
                                                      .format(waktu),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: fontSize,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 3,
                                    height: isSmallScreen ? 80 : 100,
                                    color: Colors.black,
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Hasil diagnosis :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSize,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                            height: isSmallScreen ? 5 : 10),
                                        Text(
                                          hasilDiagnosis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSize,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0c999f),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: isSmallScreen ? 80 : 90,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Text(
              'Kembali ke halaman utama',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isSmallScreen ? 15 : 17,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF0c999f), // Green background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 10px border radius
              ),
            ),
          ),
        ),
      ),
    );
  }
}
