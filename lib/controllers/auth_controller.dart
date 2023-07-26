import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthController {
  Future<String?> signUp({
    required String namaLengkap,
    required String Email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      Map<String, dynamic> data = {
        'nama_lengkap': namaLengkap,
        'Email': Email,
        // Simpan kata sandi yang dienkripsi di sini
        'password': hashPassword(password),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(data);

      return null; // Tidak ada pesan kesalahan, pendaftaran berhasil
    } catch (error) {
      String errorMessage = getErrorMessage(error);
      return errorMessage; // Mengembalikan pesan kesalahan yang spesifik
    }
  }

  String hashPassword(String password) {
    // Tambahkan logika enkripsi kata sandi di sini (misalnya bcrypt atau argon2)
    return password; // Contoh: mengembalikan kata sandi tanpa enkripsi
  }

  String getErrorMessage(error) {
    String errorMessage =
        'Terjadi kesalahan saat mendaftar. Silakan coba lagi.';

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          errorMessage = 'Email sudah digunakan oleh pengguna lain.';
          break;
        case 'invalid-email':
          errorMessage = 'Email tidak valid.';
          break;
        case 'weak-password':
          errorMessage = 'Kata sandi harus lebih dari 5 digit.';
          break;
        // Tambahkan penanganan kesalahan lain yang diperlukan di sini
      }
    }

    return errorMessage;
  }

  Future<void> signIn({
    required String Email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: password);

      if (credential.user != null) {
        Navigator.pushReplacementNamed(context, '/Home');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = getSignInErrorMessage(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid Login'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String getSignInErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        return 'Tidak ada pengguna yang ditemukan dengan email tersebut.';
      case 'wrong-password':
        return 'Password anda salah.';
      default:
        return 'Terjadi kesalahan saat sign in. Silakan coba lagi.';
    }
  }
}
