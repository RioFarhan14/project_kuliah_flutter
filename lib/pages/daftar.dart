import 'package:flutter/material.dart';
import 'package:project_pi/controllers/auth_controller.dart';

class Daftar extends StatefulWidget {
  Daftar({Key? key}) : super(key: key);

  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? namaLengkapError;
  String? EmailError;
  String? passwordError;
  String? confirmPasswordError;

  AuthController authController = AuthController();

  bool isRegistering = false;
  String registerErrorMessage = '';

  void validateFields() {
    setState(() {
      namaLengkapError =
          namaLengkapController.text.isEmpty ? 'Masukkan nama anda!' : null;
      EmailError = EmailController.text.isEmpty
          ? 'Masukkan Email yang anda inginkan'
          : null;
      passwordError = passwordController.text.isEmpty
          ? 'Masukkan password yang anda inginkan'
          : null;
      confirmPasswordError = confirmPasswordController.text.isEmpty
          ? 'Konfirmasi password yang anda inginkan'
          : passwordController.text != confirmPasswordController.text
              ? 'Password tidak cocok'
              : null;
    });
  }

  void signUp() async {
    validateFields();
    if (namaLengkapError == null &&
        EmailError == null &&
        passwordError == null &&
        confirmPasswordError == null) {
      setState(() {
        isRegistering = true;
        registerErrorMessage = '';
      });

      String namaLengkap = namaLengkapController.text;
      String Email = EmailController.text;
      String password = passwordController.text;

      String? error = await authController.signUp(
        namaLengkap: namaLengkap,
        Email: Email,
        password: password,
      );

      if (error == null) {
        // Pendaftaran berhasil, navigasi ke halaman selanjutnya
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() {
          registerErrorMessage = error;
          isRegistering = false;
        });
      }
    }
  }

  @override
  void dispose() {
    namaLengkapController.dispose();
    EmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Sign Up',
          style: TextStyle(color: Color(0xFF0c999f)),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
          color: Color(0xFF0c999f),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/GastricCare_Daftar.png',
                  height: 100,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Nama Lengkap',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: namaLengkapController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: namaLengkapError,
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: EmailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: EmailError,
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: passwordError,
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Konfirmasi Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorText: confirmPasswordError,
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: registerErrorMessage.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          registerErrorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Container(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isRegistering ? null : signUp,
                          child: isRegistering
                              ? SizedBox(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  height: 24,
                                  width: 24,
                                )
                              : Text(
                                  'SIGN UP',
                                  style: TextStyle(fontSize: 17),
                                ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF0c999f),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
