import 'package:flutter/material.dart';
import '../widgets/page_card.dart';
import 'package:go_router/go_router.dart';


class PagesGridScreen extends StatefulWidget {
  final String notebookId;
  final String sectionId;

  const PagesGridScreen({
    super.key,
    required this.notebookId,
    required this.sectionId,
  });

  @override
  State<PagesGridScreen> createState() => _PagesGridScreenState();
}

class _PagesGridScreenState extends State<PagesGridScreen> {
  List<String> pages = ['Seite 1']; // Start: nur eine Seite

  void _addPage() async {
    final controller = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Neue Seite erstellen'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Seitenname',
            hintText: 'z. B. Mathe Notizen',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) Navigator.pop(context, text);
            },
            child: const Text('Erstellen'),
          ),
        ],
      ),
    );

    if (name != null && name.isNotEmpty) {
      setState(() {
        pages.add(name);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return PageCard(
                  title: pages[index],
                  onTap: () {                    
                      context.go('/notebook/${widget.notebookId}/section/${widget.sectionId}/page/$index');
                  },
                );
              },
            ),
            // Floating Button oben rechts
            Positioned(
              top: 0,
              right: 0,
              child: FloatingActionButton(
                onPressed: _addPage,
                tooltip: 'Neue Seite',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
