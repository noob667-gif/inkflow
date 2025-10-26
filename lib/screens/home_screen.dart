import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../screens/pages_grid_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          const Expanded(
            child: PagesGridScreen(
              notebookId: '1',
              sectionId: '1',
            ),
          ),
        ],
      ),
    );
  }
}
