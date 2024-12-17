import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/Login_Screen.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Positioned(
              bottom: 50,
              left: 10,
              right: 10,
              child: Card(
                color: Colors.black.withOpacity(0.5),
                elevation: 3.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 17,
                        right: 17,
                        top: 17,
                        bottom: 10,
                      ),
                      child: Text(
                        "Refrensi Film Bioskop Online Terbaik !",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 17,
                        right: 17,
                        bottom: 17,
                      ),
                      child: Text(
                        "Halooo mau nonton yang seru-seru, login dulu yuk bentar doang ko 🤩",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Create Account
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => {
                              Navigator.pushReplacementNamed(
                                  context, '/register')
                            },
                            child: Card(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 4,
                                  bottom: 4,
                                ),
                                child: Text(
                                  "Create Account",
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Have Account
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                            top: 4,
                            bottom: 4,
                          ),
                          child: InkWell(
                            onTap: () => {
                              Navigator.pushReplacementNamed(
                                  context, '/login_account')
                            },
                            child: Card(
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0)),
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: Text(
                                    "Have Account",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
