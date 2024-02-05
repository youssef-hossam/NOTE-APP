import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/noteedit_page.dart';
import 'package:note/sqldb.dart';
import 'package:note/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  bool isloading = true;
  SqlDb sqlDb = SqlDb();
  readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM 'notes'");
    notes.addAll(response);
    if (mounted) {
      setState(() {});
    }
    isloading = false;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.Secodarycolor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('noteadd');
          },
        ),
        appBar: AppBar(
          backgroundColor: AppColor.primarycolor,
          centerTitle: true,
          title: Text(
            "Note App",
            style: GoogleFonts.singleDay(fontSize: 30.sp),
          ),
        ),
        body: isloading == true
            ? Center(child: CircularProgressIndicator())
            : ListView(children: [
                ListView.builder(
                  itemCount: notes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          title: Text("${notes[index]['title']}"),
                          subtitle: Text("${notes[index]['note']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  int response = await sqlDb.deleteData(
                                      "DELETE FROM 'notes' WHERE id = ${notes[index]['id']} ");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[index]['id']);
                                    setState(() {});
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 99, 221, 134),
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Noteedit(
                                          color: notes[index]['color'],
                                          id: notes[index]['id'],
                                          title: notes[index]['title'],
                                          note: notes[index]['note'],
                                        ),
                                      ));
                                },
                              ),
                            ],
                          )),
                    );
                  },
                )
              ]));
  }
}

     // SizedBox(
          //   height: 20,
          // ),
          // ElevatedButton(
          //   onPressed: () async {
          //     int response = await sqlDb.insertData(
          //         "INSERT INTO 'notes'('note') VALUES ('NOTE two')");
          //     print(response);
          //   },
          //   child: Text("insert data "),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // ElevatedButton(
          //   onPressed: () async {
          //     List<Map> response =
          //         await sqlDb.readData("SELECT * FROM 'notes'");
          //     print(response);
          //   },
          //   child: Text("read data "),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // ElevatedButton(
          //   onPressed: () async {
          //     int response =
          //         await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = 2 ");
          //     print(response);
          //   },
          //   child: Text("delete data "),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // ElevatedButton(
          //   onPressed: () async {
          //     int response = await sqlDb.updateData(
          //         "UPDATE 'notes' SET 'note'= 'note six' WHERE id = 6 ");
          //     print(response);
          //   },
          //   child: Text("UPDATE data "),
          // ),
