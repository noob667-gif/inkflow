import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Function(String notebookId, String sectionId)? onSectionSelected;

  const Sidebar({super.key, this.onSectionSelected});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool sidebarCollapsed = false;
  String? selectedSection;

  final Map<String, List<String>> notebooks = {
    'Notebook 1': ['Section A', 'Section B'],
  };

  void _createNotebook() {
    setState(() {
      notebooks['Neues Notebook ${notebooks.length + 1}'] = [];
    });
  }

  void _renameItem(String oldKey, String newName) {
    setState(() {
      final items = notebooks.remove(oldKey);
      if (items != null) notebooks[newName] = items;
    });
  }

  void _createSection(String notebook) {
    setState(() {
      notebooks[notebook]!.add('Neuer Abschnitt ${notebooks[notebook]!.length + 1}');
    });
  }

  void _deleteNotebook(String notebook) {
    setState(() {
      notebooks.remove(notebook);
    });
  }

  void _deleteSection(String notebook, String section) {
    setState(() {
      notebooks[notebook]!.remove(section);
      if (notebooks[notebook]!.isEmpty) {
        selectedSection = null;
      }
    });
  }

  void _toggleSidebar() {
    setState(() {
      sidebarCollapsed = !sidebarCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: sidebarCollapsed ? 40 : 240,
      duration: const Duration(milliseconds: 200),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header ---
          GestureDetector(
            onSecondaryTapDown: (details) async {
              final result = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  0,
                  0,
                ),
                items: const [
                  PopupMenuItem(
                    value: 'newNotebook',
                    child: Text('Neues Notebook'),
                  ),
                ],
              );
              if (result == 'newNotebook') _createNotebook();
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Notebooks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          // --- Notebook List ---
          Expanded(
            child: ListView(
              children: notebooks.entries.map((entry) {
                final notebookName = entry.key;
                final sections = entry.value;

                return ExpansionTile(
                  title: GestureDetector(
                    onDoubleTap: _toggleSidebar,
                    onSecondaryTapDown: (details) async {
                      final action = await showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx,
                          details.globalPosition.dy,
                          0,
                          0,
                        ),
                        items: const [
                          PopupMenuItem(
                            value: 'rename',
                            child: Text('Umbenennen'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Löschen'),
                          ),
                          PopupMenuItem(
                            value: 'newSection',
                            child: Text('Neuer Abschnitt'),
                          ),
                        ],
                      );
                      switch (action) {
                        case 'rename':
                          _renameItem(notebookName, '$notebookName (neu)');
                          break;
                        case 'delete':
                          _deleteNotebook(notebookName);
                          break;
                        case 'newSection':
                          _createSection(notebookName);
                          break;
                      }
                    },
                    child: Text(notebookName),
                  ),
                  children: sections.map((section) {
                    return GestureDetector(
                        onDoubleTap: _toggleSidebar,
                        onSecondaryTapDown: (details) async {
                          final result = await showMenu<String>(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                              0,
                              0,
                            ),
                            items: const [
                              PopupMenuItem(value: 'rename', child: Text('Umbenennen')),
                              PopupMenuItem(value: 'delete', child: Text('Löschen')),
                            ],
                          );
                          if (result == 'delete') _deleteSection(notebookName, section);
                        },
                        child: ListTile(
                          title: Text(section),
                          selected: selectedSection == section,
                          onTap: () {
                            setState(() => selectedSection = section);
                            widget.onSectionSelected?.call(notebookName, section);
                          },
                        ),
                      );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
