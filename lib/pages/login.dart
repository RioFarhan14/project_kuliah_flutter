import 'package:flutter/material.dart';
import 'daftar.dart';
import 'home.dart';
import 'package:project_pi/controllers/auth_controller.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthController authController = AuthController();
  bool isRegistering = false;

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      setState(() {
        isRegistering = true;
      });

      await authController.signIn(
        Email: email,
        password: password,
        context: context,
      );

      setState(() {
        isRegistering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Center(
                    child: Image.asset('assets/GastricCare_Daftar.png'),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Selamat Datang',
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                  SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email harus diisi';
                      }
                      // Tambahan validasi email lainnya sesuai kebutuhan
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Password',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password harus diisi';
                      }
                      // Tambahan validasi email lainnya sesuai kebutuhan
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 35),
                  Container(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isRegistering ? null : signIn,
                      child: isRegistering
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              height: 24,
                              width: 24,
                            )
                          : Text(
                              'SIGN IN',
                              style: TextStyle(fontSize: 17),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF0c999f),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Daftar()),
                          );
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(
                              fontSize: 16, color: const Color(0xFF0c999f)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
