import 'package:flutter/material.dart';

class DeleteRecommendationPage extends StatelessWidget {
  final Map<String, String> movie;
  final Function(Map<String, String>) onDelete;

  DeleteRecommendationPage({required this.movie, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excluir Filme'),
        backgroundColor: Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tem certeza que deseja excluir "${movie['titulo']}"?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onDelete(movie);
                Navigator.pop(context);
              },
              child: Text('Excluir Filme'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
