import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campus_bites/screen/home/home_screen.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Data

    //page
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //-----------Image section-----------------
            Container(
              alignment: Alignment.topCenter,
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue, // to see whether background is there
                image: DecorationImage(
                  image: AssetImage('assets/images/welcome.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //-------------Spacer---------------------
            const SizedBox(height: 40),

            //----------- Text section -----------------
            Text(
              'CampusBites',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Text(
                'Order food from your favorite campus restaurants and cafes in UTP',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF1C170D), //FF is fully opaque
                ),
              ),
            ),

            const SizedBox(height: 10),
            //-------------input field-----------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'University Email',

                  filled: true,
                  fillColor: Color(0x6F9E8747),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16.0,
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),

            //-----------------button---------------------------
            //this section and now on will be anchored to bottom
            const Spacer(),

            Container(
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate and make HomePage the root of the navigation stack
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false, // Removes ALL previous routes
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFAC738), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),

                      child: Text(
                        'Continue with email',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C170D), // Text color
                        ),
                      ),
                    ),
                  ),
                  //---------------------------Policy and terms-------------------
                  const SizedBox(height: 10),
                  Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1C170D), //FF is fully opaque
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
