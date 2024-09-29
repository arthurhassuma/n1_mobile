import 'package:flutter/material.dart';

class DeleteRecommendationPage extends StatelessWidget {
  final Map<String, String> movie;
  final Function(Map<String, String>) onDelete;

  const DeleteRecommendationPage({super.key, required this.movie, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excluir Recomendações', style: TextStyle(fontFamily: 'Proelium')),
        backgroundColor: const Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Tem certeza que deseja excluir a recomendação de "${movie['titulo']}"?',
                style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFFFFFFFF))),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onDelete(movie);
                Navigator.pop(context);
              },
              child: const Text('Excluir', style: TextStyle(fontFamily: 'Proelium')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(fontFamily: 'Proelium')),
            ),
          ],
        ),
      ),
    );
  }
}
