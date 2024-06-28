import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importe o pacote google_fonts
import 'dart:ui'; // Import necessário para usar o BackdropFilter

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página Inicial',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: Stack(
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
                          Text(
                            'Projeto :',
                            style: TextStyle(
                              fontFamily: 'NJNaruto',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Este é um pequeno texto que descreve algo interessante. '
                            'Aqui você pode adicionar qualquer informação relevante que '
                            'deseja compartilhar na sua página inicial.',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Image.asset(
                      'web/assets/assets/naruto.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
                SizedBox(height: 16), // Espaçamento entre os conjuntos de conteúdo

                // Segundo conjunto de título acima da imagem e texto ao lado da imagem
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desenvolvedores :',
                      style: TextStyle(
                        fontFamily: 'NJNaruto',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'web/assets/assets/desc.png',
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Matheus Diniz Fernandes',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Redes Sociais: ',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Image.asset(
                                  'web/assets/assets/email2.png',
                                  width: 48,
                                  height: 48,
                                ),
                                SizedBox(width: 8),
                                Image.asset(
                                  'web/assets/assets/git.png',
                                  width: 48,
                                  height: 48,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}