import 'package:flutter/material.dart';
import 'package:teste/models_widget/models_widgets.dart';

class GruposPage extends StatelessWidget {
  const GruposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Naruto',
          subtitle: ' Universe',
      ),
      body: const Center(
        child: Text('Conteúdo da página de Grupos'),
      ),
    );
  }
}