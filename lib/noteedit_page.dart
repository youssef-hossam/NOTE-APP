import 'package:flutter/material.dart';
import 'package:note/home_page.dart';
import 'package:note/sqldb.dart';

class Noteedit extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const Noteedit({super.key, this.note, this.title, this.color, this.id});

  @override
  State<Noteedit> createState() => _NoteeditState();
}

class _NoteeditState extends State<Noteedit> {
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
  void initState() {
    note.text = widget.note;
    color.text = widget.color;
    title.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("edit Notes"),
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
                    int response = await sqlDb.updateData('''
                    UPDATE notes SET 
                    note ="${note.text}" ,
                    title ="${title.text}",
                    color="${color.text}"
                     WHERE id = ${widget.id}
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
                  child: Text("ed"),
                )
              ],
            ))
      ]),
    );
  }
}
