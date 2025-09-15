import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TemplateGrid extends StatefulWidget {
  final List<Map<String, dynamic>> templates;
  const TemplateGrid({super.key, required this.templates});

  @override
  State<TemplateGrid> createState() => _TemplateGridState();
}

class _TemplateGridState extends State<TemplateGrid> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: widget.templates.length,
      itemBuilder: (context, index) {
        final template = widget.templates[index];
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onLongPress: () {
            setState(() {
              if (isSelected) {
                selectedIndex = null;
              } else {
                selectedIndex = index;
              }
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(template["imageUrl"], fit: BoxFit.cover),
                ),
              ),

              if (isSelected)
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.check, color: Colors.green, size: 18),
                  ),
                ),

              if (isSelected)
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Edit ${template['title']}")),
                        );
                      },
                      child: const Text(
                        "Edit Template",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
