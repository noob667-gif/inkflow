import 'package:flutter/material.dart';

class PageCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PageCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(child: Text(title)),
      ),
    );
  }
}
