import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final ValueChanged<String> onSelected;
  final Icon icon;

  const SortButton({
    Key? key,
    required this.onSelected,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: "A->Z",
            child: Text("A->Z"),
          ),
          PopupMenuItem<String>(
            value: "Z->A",
            child: Text("Z->A"),
          ),
        ];
      },
      icon: icon,
    );
  }
}
