import 'model/note.dart';

class NoteService {
  static List<Note> notes = [];
  static List<Note> searchNotes = [];

  void deleteNote(int index) {
    Note note = notes[index];
    notes.remove(note);
  }

  void searchNote(String searchText) {
    if (searchText.isEmpty){
      searchNotes = notes;
    }
    else {
      searchNotes = notes
          .where((note) =>
      note.title.toLowerCase().contains(searchText.toLowerCase()) ||
          note.content.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  void addnote(String title, String content){
    notes.add(Note(
        id: notes.length,
        title: title,
        content: content,
        time: DateTime.now()));
    searchNotes = notes;
  }
}