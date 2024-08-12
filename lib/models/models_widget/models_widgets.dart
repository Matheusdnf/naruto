import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teste/controller/controller_navigationbar.dart';
import 'package:teste/models/models_api/model_character.dart';
import 'package:teste/util/navega%C3%A7%C3%A3obar.dart';

class ModelButton {
  String nome;
  Icon icon;
  VoidCallback? onPressed;

  ModelButton({required this.nome, required this.icon, required this.onPressed});
}

class MyButton extends StatelessWidget {
  final List<ModelButton> modelo;

  MyButton({this.modelo = const []});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: modelo
          .map(
            (guia) => IconButton(
              icon: guia.icon,
              tooltip: guia.nome,
              onPressed: guia.onPressed,
            ),
          )
          .toList(),
    );
  }
}

class InfoDev extends StatelessWidget{
  final String name;
  final String image; 
  final List<ModelButton> socialmedia;

  InfoDev({required this.name,required this.image,required this.socialmedia
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/assets/desc.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                Text(
                  'Redes Sociais:',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 2),
                MyButton(
                  modelo: socialmedia,
                )

              ]
            ) 
          ]
        )
      ]
    );
  }
}


class ButtonInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          Get.delete<NavController>();
          Get.put(NavController());
          Get.to(()=> Teste());
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          backgroundColor: Colors.black,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.yellowAccent),
            SizedBox(width: 8),
            Text(
              'Abrir aplicativo',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

// app bar customizada
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final double fontSize;
  final Color subtitleColor;

  CustomAppBar({
    required this.title,
    required this.subtitle,
    this.fontSize = 24,
    this.subtitleColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontFamily: 'NJNaruto',
                fontSize: fontSize,
              ),
            ),
            TextSpan(
              text: subtitle,
              style: TextStyle(
                fontFamily: 'NJNaruto',
                fontSize: fontSize,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// Imagem de fundo
class ImagemBackground extends StatelessWidget {
  final String imagePath;

  const ImagemBackground({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  color: Colors.black.withOpacity(0.2), // Ajusta a opacidade para melhorar a legibilidade
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Mostragem de cards
class VillagePageView extends StatelessWidget {
  final PageController pageController;
  final List<String> imageAssets;
  final List<String> villageNames;
  final ValueChanged<int> onPageSelected;
  final int initialPage;

  VillagePageView({
    required this.pageController,
    required this.imageAssets,
    required this.villageNames,
    required this.onPageSelected,
    this.initialPage = 2,
  });

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(initialPage);
    });
    
    return PageView.builder(
      controller: pageController,
      itemCount: imageAssets.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: pageController,
          builder: (context, child) {
            double value = 1.0;
            if (pageController.position.haveDimensions) {
              value = pageController.page! - index;
              value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            }

            return Center(
              child: GestureDetector(
                onTap: () => onPageSelected(index),
                child: SizedBox(
                  height: Curves.easeOut.transform(value) * 450.0,
                  width: Curves.easeOut.transform(value) * 300.0,
                  child: child,
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    imageAssets[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      villageNames[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NJNaruto',
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


//card personagens
class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              character.images.isNotEmpty ? character.images[0] : 'https://via.placeholder.com/150',
              fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        title: Text(character.name),
        subtitle: Text('ID: ${character.id}'),
        onTap: onTap,
      ),
    );
  }
}