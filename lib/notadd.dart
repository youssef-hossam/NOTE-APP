import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/home_page.dart';
import 'package:note/sqldb.dart';
import 'package:note/theme.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    note.dispose();
    title.dispose();
    color.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.Secodarycolor,
        centerTitle: true,
        title: Text(
          "Add Notes",
          style: GoogleFonts.ptSerif(
            fontSize: 20.sp,
          ),
        ),
      ),
      body: ListView(children: [
        Form(
            key: formstate,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(hintText: "note"),
                        controller: note,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "title"),
                        controller: title,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "color"),
                        controller: color,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primarycolor),
                  onPressed: () async {
                    // int response = await sqlDb.insertData('''
                    //   INSERT INTO notes (note,title,color)
                    //   VALUES    ("${note.text}" , "${title.text}" , "${color.text}")
                    //   ''');
                    int response = await sqlDb.insert("notes", {
                      "note": "${note.text}",
                      "title": "${title.text}",
                      "color": "${color.text}",
                    });
                    print(response);
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Text(
                    "Add",
                    style: GoogleFonts.singleDay(fontSize: 30.sp),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}
