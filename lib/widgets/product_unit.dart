import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  final VoidCallback onTap; // Use VoidCallback for clarity
  final String title;

  ProductUnit({
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 5),
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.arrow_drop_down,
                size: 20,
                color: Colors.yellow, // Adjust color if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
