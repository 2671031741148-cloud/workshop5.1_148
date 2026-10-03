import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/note.dart';
import 'package:flutter_application_1/repository/note_repository.dart';
import 'package:flutter_application_1/screens/add-note/add_note_screen.dart';
import 'package:flutter_application_1/screens/widgts/item_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('My Diary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: NoteRepository.getNote(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF4F46E5)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_alt_outlined, size: 70, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text("ยังไม่มีบันทึกข้อมูล", style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final note = snapshot.data![index];
              return ItemNote(note: note);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen(note: null)),
          );
          setState(() {});
        },
        backgroundColor: const Color(0xFF4F46E5),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("เพิ่มบันทึก", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}