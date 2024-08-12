import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/groups_controller.dart';
import 'package:teste/models/models_api/model_character.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/screens/screen_personagens/personagem.dart';
import 'package:teste/util/search_bar.dart';
import 'package:teste/util/ordenador.dart';


class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late String groupName;
  final GrupoController controller = Get.find(); // Usa o mesmo controlador já instanciado
  final TextEditingController _searchController = TextEditingController();
  final RxBool nameFilter = false.obs;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      final int groupIndex = arguments['index']; // Recebe o índice do grupo passado como argumento
      groupName = arguments['name'];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchGrupo(groupIndex); // Busca os personagens do grupo selecionado
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.red[700], // Define a cor do AppBar
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: SearchBarApp(
            name: groupName,
            searchController: _searchController,
            onChanged: (query) {
              setState(() {}); // Force o build para aplicar o filtro
            },
            sortButton: SortButton(
              onSelected: (value) {
                nameFilter.value = value == "A->Z";
                setState(() {}); // Force o build para aplicar a ordenação
              },
              icon: const Icon(Icons.filter_list),
            ),
          ),
        ),
      ),

      body: 
        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.personagens.isEmpty) {
              return const Center(child: Text('Nenhum personagem encontrado.'));
            } else {
              final filteredPersonagens = controller.personagens.where((character) {
                final query = _searchController.text.toLowerCase();
                return character.name.toLowerCase().contains(query);
              }).toList();

              if (nameFilter.value) {
                filteredPersonagens.sort((a, b) => a.name.compareTo(b.name)); // Ordena de A->Z
              } else {
                filteredPersonagens.sort((a, b) => b.name.compareTo(a.name)); // Ordena de Z->A
              }


              if (filteredPersonagens.isEmpty) {
                return const Center(child: Text('Nenhum personagem encontrado.'));
              } else {
                return ListView.builder(
                  itemCount: filteredPersonagens.length,
                  itemBuilder: (context, index) {
                    final Character personagem = filteredPersonagens[index];
                      return CharacterCard(
                      character: personagem,
                      onTap: () {
                        Get.to(() => Detalhedocaracter(), arguments: personagem);
                      },
                    );
                  },
                );
              }
            }
          }),
        ),
    );
  }
}
