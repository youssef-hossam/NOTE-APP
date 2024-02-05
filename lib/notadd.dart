import 'package:flutter/material.dart';
import 'package:note/home_page.dart';
import 'package:note/sqldb.dart';

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
        centerTitle: true,
        title: const Text("Add Notes"),
      ),
      body: ListView(children: [
        Form(
            key: formstate,
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
                ElevatedButton(
                  onPressed: () async {
                    int response = await sqlDb.insertData('''
                      INSERT INTO notes (note,title,color)
                      VALUES    ("${note.text}" , "${title.text}" , "${color.text}")
                      ''');
                    print(response);
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            ))
      ]),
    );
  }
}
