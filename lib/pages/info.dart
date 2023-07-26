import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_pi/pages/home.dart';
import 'package:project_pi/widgets/ButtonNavigator.dart';
import 'package:project_pi/models/button.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  String? selectedPenyakit;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final buttonHeight = isSmallScreen ? 50.0 : 60.0;
    final buttonFontSize = isSmallScreen ? 18.0 : 20.0;
    final itemFontSize = isSmallScreen ? 16.0 : 18.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: isSmallScreen ? 10 : 20),
                child: Center(
                  child: ButtonNavigator(
                    button(
                      name: 'Informasi Penyakit',
                      ImgUrl: 'assets/info_penyakit.png',
                    ),
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 30 : 40),
              Padding(
                padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                child: Container(
                  width: double.infinity,
                  height: isSmallScreen ? 500 : 400,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('penyakit')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('No data available');
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          bool isExpanded = selectedPenyakit == document.id;

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isExpanded) {
                                      selectedPenyakit = null;
                                    } else {
                                      selectedPenyakit = document.id;
                                    }
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: buttonHeight,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0c999f),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 15 : 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data['nama'] ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: buttonFontSize,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          size: isSmallScreen ? 24 : 28,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (isExpanded)
                                Container(
                                  padding:
                                      EdgeInsets.all(isSmallScreen ? 15 : 20),
                                  color: Colors.grey[200],
                                  child: Text(
                                    data['detail'] ?? '',
                                    style: TextStyle(fontSize: itemFontSize),
                                  ),
                                ),
                              SizedBox(height: isSmallScreen ? 20 : 30),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
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
