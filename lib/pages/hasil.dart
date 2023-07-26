import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_pi/pages/home.dart';

class hasil extends StatelessWidget {
  final List<String> selectedLabels;
  final hasilpenyakit;

  const hasil(
      {Key? key, required this.selectedLabels, required this.hasilpenyakit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    return WillPopScope(
        onWillPop: () async {
          // Navigate to the Home screen when the back button is pressed
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (route) => false,
          );
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: isSmallScreen ? 220 : 200,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0c999f),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: isSmallScreen ? 30 : 25,
                        ),
                        Text(
                          'Hasil diagnosis',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: isSmallScreen ? 30 : 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: isSmallScreen ? 15 : 5,
                        ),
                        Text(
                          hasilpenyakit,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: isSmallScreen ? 18 : 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: isSmallScreen ? 20 : 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: isSmallScreen ? 350 : 330,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF0c999f)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: isSmallScreen ? 20 : 15,
                        ),
                        Text(
                          'Gejala yang dipilih',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: isSmallScreen ? 30 : 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: isSmallScreen ? 30 : 25,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: selectedLabels.length,
                            itemBuilder: (BuildContext context, int index) {
                              final gejalaNumber = index + 1;
                              final gejalaText = selectedLabels[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: isSmallScreen ? 10 : 20),
                                child: Text(
                                  '$gejalaNumber. $gejalaText',
                                  style: TextStyle(
                                      fontSize: isSmallScreen ? 18 : 17),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: isSmallScreen ? 100 : 90,
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
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 18 : 17,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF0c999f), // Warna latar belakang hijau
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Border radius 10
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
