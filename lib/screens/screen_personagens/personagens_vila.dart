import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/village_controller.dart';
import 'package:teste/models/models_api/model_character.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/screens/screen_personagens/personagem.dart';
import 'package:teste/util/ordenador.dart';
import 'package:teste/util/search_bar.dart'; // Importando a classe SearchBarApp

// Tela principal para exibir personagens de uma vila específica.
class VilaScreen extends StatefulWidget {
  const VilaScreen({super.key});

  @override
  _VilaScreenState createState() => _VilaScreenState();
}

class _VilaScreenState extends State<VilaScreen> {
  late String name; // Armazena o nome da vila
  final VillageController controller = Get.find(); // Instancia o controlador do GetX
  final TextEditingController _searchController = TextEditingController(); // Controlador para a barra de pesquisa
  final RxBool nameFilter = false.obs; // Variável observável para rastrear a ordenação

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?; // Obtém os argumentos passados para a tela
    if (arguments != null) {
      final int villageId = arguments['id']; // Obtém o ID da vila dos argumentos
      name = arguments['name']; // Obtém o nome da vila dos argumentos
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchCharacter(villageId); // Chama o método para buscar os personagens da vila específica
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Define a altura do AppBar
        child: AppBar(
          backgroundColor: Colors.red[700], // Define a cor do AppBar
          iconTheme: const IconThemeData(
            color: Colors.white, // Define a cor dos ícones no AppBar
          ),
          title: SearchBarApp(
            name: name, // Nome da vila
            searchController: _searchController, // Controlador da barra de pesquisa
            onChanged: (query) {
              setState(() {}); // Força a reconstrução da interface ao digitar na barra de pesquisa
            },
            sortButton: SortButton(
              onSelected: (value) {
                nameFilter.value = value == "A->Z"; // Define a ordenação com base na seleção do usuário
                setState(() {}); // Força a reconstrução da interface ao alterar a ordenação
              },
              icon: const Icon(Icons.filter_list), // Ícone para o botão de ordenação
            ),
          ),
        ),
      ),
      
      // Corpo da tela onde os personagens da vila são exibidos
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // Exibe um indicador de carregamento enquanto os dados são carregados
        } else if (controller.vila.isEmpty) {
          return const Center(child: Text('Nenhum personagem encontrado.')); // Exibe uma mensagem caso nenhum personagem seja encontrado
        } else {
          final filteredVila = controller.vila.where((character) {
            final query = _searchController.text.toLowerCase(); // Obtém a consulta da barra de pesquisa em letras minúsculas
            return character.name.toLowerCase().contains(query); // Filtra os personagens que contêm a consulta no nome
          }).toList();

          // Aplica a ordenação com base na seleção do usuário
          if (nameFilter.value) {
            filteredVila.sort((a, b) => a.name.compareTo(b.name)); // Ordena os personagens de A->Z
          } else {
            filteredVila.sort((a, b) => b.name.compareTo(a.name)); // Ordena os personagens de Z->A
          }

          if (filteredVila.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado.')); // Exibe uma mensagem se nenhum personagem corresponder à pesquisa
          } else {
            // Exibe os personagens filtrados e ordenados em uma lista
            return ListView.builder(
              itemCount: filteredVila.length, // Número de personagens na lista
              itemBuilder: (context, index) {
                final Character vila = filteredVila[index]; // Obtém o personagem no índice atual
                return CharacterCard(
                  character: vila, // Passa o personagem para o cartão
                  onTap: () {
                    Get.to(() => Detalhedocaracter(), arguments: vila); // Navega para a tela de detalhes do personagem ao clicar no cartão
                  },
                );
              },
            );
          }
        }
      }),
    );
  }
}
