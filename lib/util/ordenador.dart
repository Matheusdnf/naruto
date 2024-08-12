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
      // Chama a função `onSelected` ao selecionar uma opção.
      onSelected: onSelected,
      // Define as opções do menu.
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: "A->Z",
            child: Text("A->Z"),
          ),
          const PopupMenuItem<String>(
            value: "Z->A",
            child: Text("Z->A"),
          ),
        ];
      },
      // Ícone do botão.
      icon: icon,
    );
  }
}
