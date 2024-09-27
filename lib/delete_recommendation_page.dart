import 'dart:io';
import 'package:flutter/material.dart';

class DeleteRecommendationPage extends StatelessWidget {
  final Map<String, String> movie;
  final Function(Map<String, String>) onDelete;

  const DeleteRecommendationPage({super.key, required this.movie, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final String? imagePath = movie['imagem'];

    // Validação para checar se o arquivo da imagem existe
    bool imageExists = imagePath != null && File(imagePath).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Excluir Recomendação'),
        backgroundColor: const Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Se a imagem existir, exibe, caso contrário, exibe um placeholder
            imageExists
                ? Image.file(
              File(imagePath!), // Usar File para carregar a imagem
              height: 200,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/placeholder.png', // Placeholder quando a imagem não existir
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              'Você tem certeza que deseja excluir "${movie['titulo']}"?',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onDelete(movie); // Chama a função de exclusão
                    Navigator.pop(context); // Volta para a página anterior
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF0000)),
                  child: const Text('Sim'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Apenas volta
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF149C68)),
                  child: const Text('Não'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
