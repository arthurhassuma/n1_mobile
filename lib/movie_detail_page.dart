import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<String, String> movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['titulo']!),
        backgroundColor: Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              movie['titulo']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF149C68)),
            ),
            SizedBox(height: 10),
            Text('Categoria: ${movie['categoria']!}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Descrição:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(movie['descricao'] ?? 'Sem descrição', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Nota: ${movie['nota']!}/5', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
