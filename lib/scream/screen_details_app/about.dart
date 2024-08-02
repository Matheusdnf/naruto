import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importe o pacote google_fonts
import 'package:teste/models_widget/models_widgets.dart';
import 'dart:ui'; // Import necessário para usar o BackdropFilter
import 'package:url_launcher/url_launcher.dart';
import 'package:icons_plus/icons_plus.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Projeto'),
      ),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          BlurredBackground(),
          Content(),
        ],
      ),
    );
  }
}

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'web/assets/assets/tropa.jpg',
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Primeiro conjunto de título, texto e imagem
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Projeto :',
                            style: TextStyle(
                              fontFamily: 'NJNaruto',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Este projeto foi desenvolvido para a matéria de POO para a faculdade (UFRN).\n'
                            'Tem como temática a série japonesa naruto, contendo algumas informanções e personagens do anime.',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      'web/assets/assets/naruto.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Espaçamento entre os conjuntos de conteúdo

                // Segundo conjunto de título acima da imagem e texto ao lado da imagem
                const DeveloperInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({super.key});

  void abrir_github(String git) async {
    var github = git;
    if (await canLaunchUrl(Uri.parse(github))) {
      await launchUrl(Uri.parse(github));
    } else {
      throw 'Could not launch $github';
    }
  }

  void abrirInstagram(String insta) async {
    var instagram = insta;
    if (await canLaunchUrl(Uri.parse(instagram))) {
      await launchUrl(Uri.parse(instagram));
    } else {
      throw 'Could not launch $instagram';
    }
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('subject=Gostei do Projeto&body=Vou lhe dar dinheiro por ele'),
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        throw 'Could not launch $emailLaunchUri';
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Desenvolvedores:',
          style: TextStyle(
            fontFamily: 'NJNaruto',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        InfoDev(
          name: 'Matheus Diniz Fernandes',
          image: 'https://i.ytimg.com/vi/kWC-mNkGKtk/maxresdefault.jpg',
          socialmedia: [
            ModelButton(
              nome: 'Email',
              icon: Icon(Icons.email_outlined),
              onPressed: () => _launchEmail('matheusdiniz870@gmail.com'),
            ),
            ModelButton(
              nome: 'Instagram',
              icon: Icon(Bootstrap.instagram),
              onPressed: () => abrirInstagram('https://www.instagram.com/Matheusdnz_'),
            ),
            ModelButton(
              nome: 'Github',
              icon: Icon(Bootstrap.github),
              onPressed: () => abrir_github('https://github.com/Matheusdnf'),
            ),
          ],
        ),
        SizedBox(height: 10),
        InfoDev(
          name: 'Felipe Algusto',
          image: 'https://i.ytimg.com/vi/kWC-mNkGKtk/maxresdefault.jpg',
          socialmedia: [
            ModelButton(
              nome: 'Email',
              icon: Icon(Icons.email_outlined),
              onPressed: () => _launchEmail('araujofelipe54@gmail.com'),
            ),
            ModelButton(
              nome: 'Instagram',
              icon: Icon(Bootstrap.instagram),
              onPressed: () => abrirInstagram('https://www.instagram.com/august_felpss/'),
            ),
            ModelButton(
              nome: 'Github',
              icon: Icon(Bootstrap.github),
              onPressed: () => abrir_github('https://github.com/fel-ps'),
            ),
          ],
        ),
      ],
    );
  }
}
