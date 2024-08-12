import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/village_controller.dart';
import 'package:teste/models/models_api/model_character.dart';
import 'package:teste/models/models_widget/models_widgets.dart';
import 'package:teste/screens/screen_personagens/personagem.dart';
import 'package:teste/util/ordenador.dart';
import 'package:teste/util/search_bar.dart';// Importando a nova classe

class VilaScreen extends StatefulWidget {
  const VilaScreen({super.key});

  @override
  _VilaScreenState createState() => _VilaScreenState();
}

class _VilaScreenState extends State<VilaScreen> {
  late String name;
  final VillageController controller = Get.find();
  final TextEditingController _searchController = TextEditingController();
  final RxBool nameFilter = false.obs; // Adicionado para rastrear a ordenação

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      final int villageId = arguments['id'];
      name = arguments['name'];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchCharacter(villageId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.red[700], // Define a cor do AppBar
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: SearchBarApp(
            name: name,
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


      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.vila.isEmpty) {
          return const Center(child: Text('Nenhum personagem encontrado.'));
        } else {
          final filteredVila = controller.vila.where((character) {
            final query = _searchController.text.toLowerCase();
            return character.name.toLowerCase().contains(query);
          }).toList();

          if (nameFilter.value) {
            filteredVila.sort((a, b) => a.name.compareTo(b.name)); // Ordena de A->Z
          } else {
            filteredVila.sort((a, b) => b.name.compareTo(a.name)); // Ordena de Z->A
          }

          if (filteredVila.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado.'));
          } else {
            return ListView.builder(
              itemCount: filteredVila.length,
              itemBuilder: (context, index) {
                final Character vila = filteredVila[index];
                return CharacterCard(
                  character: vila,
                  onTap: () {
                    Get.to(() => Detalhedocaracter(), arguments: vila);
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
