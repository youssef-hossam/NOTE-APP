import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Image.asset("assets/images/Mobile note list (3).gif"),
          SizedBox(
            height: 70.h,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'homepage');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 25.w),
                backgroundColor: Color.fromARGB(255, 99, 221, 134),
              ),
              child: Text(
                "let's go",
                style: GoogleFonts.singleDay(
                  fontSize: 26.sp,
                ),
              ))
        ],
      ),
    );
  }
}
