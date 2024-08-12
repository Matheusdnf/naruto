import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teste/models/models_api/model_character.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Detalhedocaracter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Character personagem = Get.arguments as Character;
    //mostrar as imagens, animação de transição entre elas
    final PageController _pageController = PageController();
    //obtem o tamanho da largura total da tela
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(personagem.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:ListView(
          children: [ 
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 122, // Altura do PageView
              child: PageView.builder(
                controller: _pageController,
                itemCount: personagem.images.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: ClipOval(
                      child: Container(
                        width: 122,
                        height: 122,
                        child: Image.network(
                          personagem.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
             if (personagem.images.length > 1)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),  
                  ],
                ),
              ),
            const SizedBox(height: 10),
            const Text(
              'Jutsus:',
              style: TextStyle(fontFamily: 'NJNaruto'),
            ),
            Container(
              width: screenWidth, // Largura total da tela
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                elevation: 4, // elevação para dar um efeito de sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // bordas arredondadas
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Adiciona padding ao redor do conteúdo
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda
                    children: personagem.jutsu.isNotEmpty
                        ? personagem.jutsu.map((jutsu) => Text('- $jutsu')).toList()
                        : [const Text("Tem nada aqui não colega")],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Estreia:',
              style: TextStyle(fontFamily: 'NJNaruto'),
            ),
            Container(
              width: screenWidth, // Largura total da tela
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                elevation: 4, // elevação para dar um efeito de sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // bordas arredondadas
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Adiciona padding ao redor do conteúdo
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda
                    children: [
                      Text('Mangá: ${personagem.debut.manga ?? 'Não especificado'}'),
                      Text('Anime: ${personagem.debut.anime ?? 'Não especificado'}'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
          ]
      ),
      )
    );
  }
}