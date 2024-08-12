import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  final String name;
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;
  final Widget sortButton; // Novo campo para o SortButton

  const SearchBarApp({
    Key? key,
    required this.searchController,
    required this.onChanged,
    required this.name,
    required this.sortButton, // Novo parâmetro
  }) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isSearchClicked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isSearchClicked
              ? Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: widget.searchController,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
                      hintText: 'Naruto..',
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'NJNaruto',
                    ),
                  ),
                ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isSearchClicked = !isSearchClicked;
              if (!isSearchClicked) {
                widget.searchController.clear();
                widget.onChanged('');
              }
            });
          },
          icon: Icon(
            isSearchClicked ? Icons.close : Icons.search,
          ),
        ),
        widget.sortButton, // Adiciona o SortButton ao lado direito
      ],
    );
  }
}
