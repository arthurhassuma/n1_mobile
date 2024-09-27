import 'dart:io';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<String, String> movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final String? imagePath = movie['imagem'];

    // Validação para checar se o arquivo da imagem existe
    bool imageExists = imagePath != null && File(imagePath).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['titulo']!),
        backgroundColor: const Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
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
            Center(
              child: Text(
                'Descrição: ${movie['descricao']}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Centraliza o texto
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Categoria: ${movie['categoria']}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Centraliza o texto
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Nota: ${movie['nota']}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Centraliza o texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
