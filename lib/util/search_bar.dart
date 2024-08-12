import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  final String name; // Nome a ser exibido quando a barra de pesquisa não está ativa.
  final TextEditingController searchController; // Controlador para o campo de texto da barra de pesquisa.
  final ValueChanged<String> onChanged; // Função a ser chamada quando o texto da pesquisa muda.
  final Widget sortButton; // Botão de ordenação que será exibido ao lado da barra de pesquisa.

  const SearchBarApp({
    Key? key,
    required this.searchController,
    required this.onChanged,
    required this.name,
    required this.sortButton,
  }) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isSearchClicked = false; // Indica se a barra de pesquisa foi ativada.

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expande o widget filho para ocupar o máximo de espaço possível.
        Expanded(
          child: isSearchClicked
              ? Container(
                  // Exibe a barra de pesquisa quando ativada.
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
                      hintText: 'Naruto..', // Placeholder para o campo de texto.
                    ),
                  ),
                )
              : Center(
                  // Exibe o nome quando a barra de pesquisa não está ativa.
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
        // Botão para ativar/desativar a barra de pesquisa.
        IconButton(
          onPressed: () {
            setState(() {
              isSearchClicked = !isSearchClicked;
              if (!isSearchClicked) {
                widget.searchController.clear();
                widget.onChanged(''); // Limpa o texto da pesquisa quando a barra é desativada.
              }
            });
          },
          icon: Icon(
            isSearchClicked ? Icons.close : Icons.search, // Alterna o ícone entre "close" e "search".
          ),
        ),
        widget.sortButton, // Adiciona o botão de ordenação ao lado direito.
      ],
    );
  }
}
