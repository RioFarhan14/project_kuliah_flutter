import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_pi/pages/hasil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Diagnosis extends StatefulWidget {
  @override
  _DiagnosisState createState() => _DiagnosisState();
}

class Gejala {
  final String id;
  final String nama;

  Gejala({required this.id, required this.nama});
}

class _DiagnosisState extends State<Diagnosis> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  List<Gejala> gejalaList = [];
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    getGejalaList();
  }

  Future<void> _getCurrentUser() async {
    User? user = _auth.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  Future<void> getGejalaList() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('gejala').get();

      List<Gejala> list = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Gejala(id: data['ID_gejala'], nama: data['nama']);
      }).toList();

      List<bool> options = List.filled(list.length, false);

      setState(() {
        gejalaList = list;
        selectedOptions = options;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  String getLabel(int index) {
    if (index >= 0 && index < gejalaList.length) {
      return gejalaList[index].nama;
    }
    return '';
  }

  String getId(int index) {
    if (index >= 0 && index < gejalaList.length) {
      return gejalaList[index].id;
    }
    return '';
  }

  String hasilpenyakit(List<String> selectedids) {
    if (selectedids.contains('G1') &&
        selectedids.contains('G2') &&
        selectedids.contains('G3') &&
        selectedids.contains('G4') &&
        selectedids.contains('G5') &&
        selectedids.contains('G22') &&
        selectedids.contains('G26')) {
      return 'Gastritis, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya';
    } else if (selectedids.contains('G1') &&
        selectedids.contains('G2') &&
        selectedids.contains('G3') &&
        selectedids.contains('G4') &&
        selectedids.contains('G5') &&
        selectedids.contains('G6') &&
        selectedids.contains('G8') &&
        selectedids.contains('G20') &&
        selectedids.contains('G22') &&
        selectedids.contains('G26')) {
      return 'Dipepsia, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya';
    } else if (selectedids.contains('G3') &&
        selectedids.contains('G4') &&
        selectedids.contains('G5') &&
        selectedids.contains('G7') &&
        selectedids.contains('G13') &&
        selectedids.contains('G14') &&
        selectedids.contains('G15') &&
        selectedids.contains('G16') &&
        selectedids.contains('G17') &&
        selectedids.contains('G18') &&
        selectedids.contains('G19') &&
        selectedids.contains('G21') &&
        selectedids.contains('G26')) {
      return 'Gastroesophageal reflux disease (GERD), Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya';
    } else if (selectedids.contains('G1') &&
        selectedids.contains('G2') &&
        selectedids.contains('G3') &&
        selectedids.contains('G4') &&
        selectedids.contains('G5') &&
        selectedids.contains('G6') &&
        selectedids.contains('G10') &&
        selectedids.contains('G11') &&
        selectedids.contains('G12') &&
        selectedids.contains('G20') &&
        selectedids.contains('G26')) {
      return 'Kanker lambung, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya';
    } else if (selectedids.contains('G3') &&
        selectedids.contains('G5') &&
        selectedids.contains('G6') &&
        selectedids.contains('G9') &&
        selectedids.contains('G20') &&
        selectedids.contains('G21') &&
        selectedids.contains('G24') &&
        selectedids.contains('G25') &&
        selectedids.contains('G26')) {
      return 'Gastroenteritis, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya';
    } else if (selectedids.contains('G3') &&
        selectedids.contains('G5') &&
        selectedids.contains('G6') &&
        selectedids.contains('G10') &&
        selectedids.contains('G21') &&
        selectedids.contains('G25') &&
        selectedids.contains('G26')) {
      return 'Gastroparesis, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya';
    } else {
      return 'Penyakit tidak diketahui, Silahkan pergi ke dokter untuk mencari tahu penyakit yang anda derita';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    gejalaList.sort((a, b) {
      final idA = int.tryParse(a.id.substring(1)) ?? 0;
      final idB = int.tryParse(b.id.substring(1)) ?? 0;
      return idA.compareTo(idB);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Diagnosis',
          style: TextStyle(color: Color(0xFF0c999f)),
        ),
        toolbarHeight: 70,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
          color: const Color(0xFF0c999f),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: isSmallScreen ? 150 : 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0c999f),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Silahkan memilih gejala yang anda alami',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: gejalaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CheckboxListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: selectedOptions[index]
                                  ? const Color(0xFF0c999f)
                                  : Colors.grey,
                            ),
                          ),
                          title: Text(
                            getLabel(index),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: selectedOptions[index]
                                  ? const Color(0xFF0c999f)
                                  : Colors.grey,
                            ),
                          ),
                          value: selectedOptions[index],
                          onChanged: (bool? value) {
                            setState(() {
                              selectedOptions[index] = value ?? false;
                            });
                          },
                          activeColor: const Color(
                              0xFF0c999f), // Mengubah warna checkbox yang terpilih
                          checkColor: Colors
                              .white, // Mengubah warna tanda centang checkbox
                          checkboxShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: selectedOptions.contains(true)
          ? BottomAppBar(
              child: Container(
                height: 70,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    List<String> selectedLabels = [];
                    List<String> selectedids = [];
                    for (int i = 0; i < selectedOptions.length; i++) {
                      if (selectedOptions[i]) {
                        selectedLabels.add(getLabel(i));
                        selectedids.add(getId(i));
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => hasil(
                            selectedLabels: selectedLabels,
                            hasilpenyakit: hasilpenyakit(selectedids),
                          ),
                        ));

                    if (hasilpenyakit(selectedids) ==
                        'Gastroparesis, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya') {
                      String diagnosisResult = 'Gastroparesis';
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else if (hasilpenyakit(selectedids) ==
                        'Gastroenteritis, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya') {
                      String diagnosisResult = 'Gastroenteritis';
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else if (hasilpenyakit(selectedids) ==
                        'Kanker lambung, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya') {
                      String diagnosisResult = 'Kanker lambung';
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else if (hasilpenyakit(selectedids) ==
                        'Gastroesophageal reflux disease (GERD), Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya') {
                      String diagnosisResult =
                          'Gastroesophageal reflux disease (GERD)';
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else if (hasilpenyakit(selectedids) ==
                        'Dipepsia, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya') {
                      String diagnosisResult = 'Dipepsia';
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else if (hasilpenyakit(selectedids) ==
                        'Gastritis, Silahkan pergi ke dokter untuk berkonsultasi cara menanganinya') {
                      String diagnosisResult = 'Gastritis';
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    } else if (hasilpenyakit(selectedids) !=
                        'Penyakit tidak diketahui, Silahkan pergi ke dokter untuk mencari tahu penyakit yang anda derita') {
                      String diagnosisResult = hasilpenyakit(selectedids);
                      DateTime currentTime = DateTime.now();
                      try {
                        await FirebaseFirestore.instance
                            .collection('riwayat_diagnosa')
                            .add({
                          'user_id': _currentUser?.uid,
                          'hasilpenyakit': diagnosisResult,
                          'timestamp': currentTime,
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    }
                  },
                  child: Text('Tampilkan Hasil Diagnosis'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF0c999f), // Warna latar belakang hijau
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Border radius 10
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
