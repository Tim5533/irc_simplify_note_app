import 'package:flutter/material.dart';
import 'package:irc_simplify_note_app/view/input_page.dart';
import 'package:irc_simplify_note_app/model/note.dart';
import 'package:irc_simplify_note_app/note_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NoteService service = NoteService();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To Do List',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.sort,
                    size: 45,
                  ),
                ),
              ],
            ),
            TextField(
              onChanged: service.searchNote,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for......',
                hintStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade400,
                ),
                fillColor: Colors.grey.shade700,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(40),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: service.searchNotes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: '${service.searchNotes[index].title}\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                              children: [
                                TextSpan(
                                  text: '${service.searchNotes[index].content}\n',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            '${service.searchNotes[index].time}',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                service.deleteNote(index);
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          final result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => InputPage()));
          setState(() {
            if (result != null) {
              service.addnote(result[0], result[1]);
            }
          });
        },
        icon: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
