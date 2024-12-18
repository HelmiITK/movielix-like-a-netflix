import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielix/components/custom_app_bar_widget.dart';
import 'package:movielix/components/bottom_navigation_bar_widget.dart';
import 'package:movielix/provider/auth_provider.dart';
import 'package:movielix/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = AuthProvider();
  auth.User? _user;

  int _selectedIndex = 2;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigasi ke halaman yang sesuai berdasarkan index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/TvSeries');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  // bool _obscurePassword = true; // Password disembunyikan secara default
  bool setUser = false;

  // Get User from firebase
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final user = await _auth.getMe();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style: GoogleFonts.poppins(
                  color: Colors.red[900],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Card Profile
              _buildProfileCard(),
              const SizedBox(height: 40),

              // Button Logout
              ElevatedButton.icon(
                onPressed: _logout,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Copyright Section
              const SizedBox(height: 200),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '© 2024 Helmi as developer. All rights reserved.',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }

  goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  _logout() async {
    await _auth.signout();

    // Pastikan widget masih terpasang sebelum mengakses context
    if (mounted) {
      goToLogin(context);
    }
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 9), // Mengatur arah bayangan
          ),
        ],
      ),
      child: Card(
        color: const Color.fromARGB(255, 0, 0, 0),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            color: Color.fromARGB(255, 218, 24, 10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Name',
                    style: GoogleFonts.poppins(
                      color: Colors.red[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _user?.displayName ?? 'Name is notfound',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.red),
              const SizedBox(height: 10),

              // Email field
              Row(
                children: [
                  const Icon(Icons.email, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      color: Colors.red[900],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _user?.email ?? 'Email is notfound',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.red),
              const SizedBox(height: 10),

              // Password field
              // Row(
              //   children: [
              //     const Icon(Icons.lock, color: Colors.white),
              //     const SizedBox(width: 10),
              //     Text(
              //       'Password',
              //       style: GoogleFonts.poppins(
              //         color: Colors.red[900],
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 5),
              // Row(
              //   children: [
              //     // Password text
              //     Expanded(
              //       child: Text(
              //         _obscurePassword ? '••••••••' : 'password123',
              //         style: GoogleFonts.poppins(
              //           color: Colors.white,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ),
              //     // Eye icon button
              //     IconButton(
              //       icon: Icon(
              //         _obscurePassword
              //             ? Icons.visibility_off
              //             : Icons.visibility,
              //         color: Colors.white,
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           _obscurePassword = !_obscurePassword;
              //         });
              //       },
              //     ),
              //   ],
              // ),

              // // Button untuk mengubah password
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _showChangePasswordDialog,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red[900],
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: Text(
              //     'Change Password',
              //     style: GoogleFonts.poppins(
              //       color: Colors.white,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // _showChangePasswordDialog() {
  //   TextEditingController currentPasswordController = TextEditingController();
  //   TextEditingController newPasswordController = TextEditingController();
  //   TextEditingController confirmPasswordController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Change Password',
  //           style: GoogleFonts.poppins(color: Colors.red[900]),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: currentPasswordController,
  //               obscureText: true,
  //               decoration: const InputDecoration(
  //                 labelText: 'Current Password',
  //                 icon: Icon(Icons.lock),
  //               ),
  //             ),
  //             TextField(
  //               controller: newPasswordController,
  //               obscureText: true,
  //               decoration: const InputDecoration(
  //                 labelText: 'New Password',
  //                 icon: Icon(Icons.lock_outline),
  //               ),
  //             ),
  //             TextField(
  //               controller: confirmPasswordController,
  //               obscureText: true,
  //               decoration: const InputDecoration(
  //                 labelText: 'Confirm New Password',
  //                 icon: Icon(Icons.lock_outline),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               'Cancel',
  //               style: GoogleFonts.poppins(color: Colors.red[900]),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               // Validasi dan update password
  //               if (newPasswordController.text ==
  //                   confirmPasswordController.text) {
  //                 try {
  //                   await _user?.updatePassword(newPasswordController.text);
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(content: Text('Password updated successfully')),
  //                   );
  //                   Navigator.of(context).pop();
  //                 } catch (e) {
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(content: Text('Failed to update password: $e')),
  //                   );
  //                 }
  //               } else {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text('Passwords do not match')),
  //                 );
  //               }
  //             },
  //             child: Text(
  //               'Change',
  //               style: GoogleFonts.poppins(color: Colors.red[900]),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
