import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/controller/village_controller.dart';
import 'package:teste/scream/detail_screen/detail_character.dart';
import 'package:teste/models/model_character.dart';

class VilaScreen extends StatefulWidget {
  const VilaScreen({super.key});

  @override
  _VilaScreenState createState() => _VilaScreenState();
}

class _VilaScreenState extends State<VilaScreen> {
  late String name;
  final VillageController controller = Get.find(); // Usa o mesmo controlador já instanciado
  final TextEditingController _searchController = TextEditingController();
  bool _folded = true;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      final int villageId = arguments['id']; // Recebe o ID da vila passado como argumento
      name = arguments['name'];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchCharacter(villageId); // Busca os personagens da vila selecionada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ninjas de $name'),
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.vila.isEmpty) {
              return const Center(child: Text('Nenhum personagem encontrado.'));
            } else {
              final filteredVila = controller.vila.where((character) {
                final query = _searchController.text.toLowerCase();
                return character.name.toLowerCase().contains(query);
              }).toList();

              return ListView.builder(
                itemCount: filteredVila.length,
                itemBuilder: (context, index) {
                  final Character vila =  filteredVila[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4, // elevação para dar um efeito de sombra
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // bordas arredondadas
                    ),
                    child: ListTile(
                      leading: SizedBox(
                        width: 50, // Define a largura do contêiner
                        height: 50, // Define a altura do contêiner
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0), // Define o raio da borda arredondada
                          child: Image.network(
                            vila.images.isNotEmpty ? vila.images[0] : 'https://via.placeholder.com/150',
                            fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      title: Text(vila.name),
                      subtitle: Text('ID: ${vila.id}'),
                      onTap: () {
                        Get.to(() => Detalhedocaracter(), arguments: vila);
                      },
                    ),
                  );
                },
              );
            }
          }),
          // SEARCH BAR
          Positioned(
            bottom: 16,
            right: 20,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: _folded ? 56 : 200,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.white,
                boxShadow: kElevationToShadow[6],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: !_folded
                          ? TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Naruto',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                              ),
                              onChanged: (query) {
                                setState(() {
                                  // Adicione sua lógica de busca aqui
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_folded ? 32 : 0),
                          topRight: const Radius.circular(32),
                          bottomLeft: Radius.circular(_folded ? 32 : 0),
                          bottomRight: const Radius.circular(32),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            _folded ? Icons.search : Icons.close,
                            color: Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _folded = !_folded;
                            if (_folded) {
                              _searchController.clear();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
