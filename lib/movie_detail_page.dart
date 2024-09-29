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
        title: Text(
          movie['titulo']!,
          style: const TextStyle(
            fontFamily: 'Proelium', // Mantém a mesma fonte
            color: Color(0xFFfffedb), // Cor do texto
          ),
        ),
        backgroundColor: const Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Se a imagem existir, exibe, caso contrário, exibe um placeholder
            imageExists
                ? Image.file(
              File(imagePath),
              height: 200,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.movie, size: 200),
            const SizedBox(height: 20),

            // Categoria
            Center(
              child: Text(
                'Categoria:',
                style: const TextStyle(
                  fontSize: 24, // Aumenta o tamanho da fonte
                  color: Color(0xFFfffedb),
                  fontFamily: 'Proelium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${movie['categoria']}',
                style: const TextStyle(
                  fontSize: 22, // Aumenta o tamanho da fonte
                  color: Color(0xFF149C68), // Alterada para #149C68
                  fontFamily: 'Proelium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Nota
            Center(
              child: Text(
                'Nota:',
                style: const TextStyle(
                  fontSize: 24, // Aumenta o tamanho da fonte
                  color: Color(0xFFfffedb),
                  fontFamily: 'Proelium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${movie['nota']}',
                    style: const TextStyle(
                      fontSize: 22, // Aumenta o tamanho da fonte
                      color: Color(0xFF149C68), // Alterada para #149C68
                      fontFamily: 'Proelium',
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.star,
                    color: Color(0xFF149C68), // Alterada para #149C68
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Descrição
            Center(
              child: Text(
                'Descrição:',
                style: const TextStyle(
                  fontSize: 24,
                  color: Color(0xFFfffedb),
                  fontFamily: 'Proelium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${movie['descricao']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFfffedb),
                  fontFamily: 'Proelium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
