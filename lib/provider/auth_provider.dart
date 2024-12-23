import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthProvider {
  final _auth = auth.FirebaseAuth.instance;

  // register
  Future<auth.User?> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final created = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // simpan nusername user
      if (created.user != null && name.isNotEmpty) {
        await created.user!.updateDisplayName(name);
        await created.user!.reload();
        await created.user!
            .sendEmailVerification(); // Tambahkan ini jika ingin verifikasi email
        log("User id: ${created.user!.uid} registered and verification email sent.");
      }

      return created.user;
    } catch (e) {
      log("Terjadi kesalahan beb");
    }
    return null;
  }

  //login
  Future<auth.User?> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final created = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return created.user;
    } catch (e) {
      log("Terjadi kesalahan beb");
    }
    return null;
  }

  //logout
  Future<void> signout() async {
    try {
      _auth.signOut();
      log('User has logout');
    } catch (e) {
      log("Terjadi kesalahan beb");
    }
  }

  //Get User
  Future<auth.User?> getMe() async {
    try {
      final user = _auth.currentUser;
      return user;
    } catch (e) {
      log("Try wrong something when geting user: $e");
      return null;
    }
  }

  // Update Password
  Future<bool> updatePassword(String newPassword) async {
    try {
      if (newPassword.isEmpty) {
        log("Password baru tidak boleh kosong.");
        return false;
      }

      final user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        await user.reload();
        log("Password berhasil diperbarui untuk user ${user.uid}.");
        return true;
      } else {
        log("Tidak ada user yang sedang login.");
      }
    } on auth.FirebaseAuthException catch (e) {
      log("Error saat memperbarui password: ${e.message}");
    } catch (e) {
      log("Kesalahan tidak diketahui: $e");
    }
    return false;
  }
}
