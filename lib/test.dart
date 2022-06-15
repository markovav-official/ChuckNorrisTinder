import 'package:chuck_norris_tinder/cards.dart';
import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final CardsState parent;
  final Set<String> categories;

  const DropdownMenu(this.parent, this.categories, {Key? key})
      : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.parent.selectedCategory,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          widget.parent.selectedCategory = newValue!;
          widget.parent.refreshAll();
        });
      },
      items: widget.categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
