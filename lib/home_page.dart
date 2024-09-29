import 'dart:io';
import 'package:flutter/material.dart';
import 'add_recommendation_page.dart';
import 'movie_detail_page.dart';
import 'delete_recommendation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> recommendations = [];
  List<Map<String, String>> _filteredRecommendations = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todos';

  @override
  void initState() {
    super.initState();
    recommendations = [];
    _filteredRecommendations = recommendations;
  }

  void addRecommendation(Map<String, String> movie) {
    setState(() {
      recommendations.add(movie);
      _filteredRecommendations = recommendations; // Atualiza as recomendações filtradas
    });
  }

  void deleteRecommendation(Map<String, String> movie) {
    setState(() {
      recommendations.remove(movie);
      _filteredRecommendations = recommendations; // Atualiza as recomendações filtradas
    });
  }

  void _searchMovies() {
    setState(() {
      _filteredRecommendations = recommendations.where((movie) {
        return movie['titulo']?.toLowerCase().contains(_searchController.text.toLowerCase() ?? '') ?? false;
      }).toList();
    });
  }

  void _filterByCategory() {
    setState(() {
      if (_selectedCategory == 'Todos') {
        _filteredRecommendations = recommendations;
      } else {
        _filteredRecommendations = recommendations.where((movie) {
          return movie['categoria'] == _selectedCategory;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FILMU - Recomendações de Filmes', style: TextStyle(fontFamily: 'Proelium', color: Color(0xFFfffedb))),
        backgroundColor: const Color(0xFF149c68),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRecommendationPage(onAdd: addRecommendation),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                elevation: 5,
              ),
              child: const Icon(Icons.add, color: Color(0xFF000000), size: 30),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFFFFFFFF)), // Define a cor do texto de entrada
              decoration: InputDecoration(
                labelText: 'Buscar filmes',
                labelStyle: const TextStyle(fontFamily: 'Proelium', color: Color(0xFFFFFFFF)), // Cor do label
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFFFFFFFF)), // Cor do ícone de busca
                  onPressed: _searchMovies,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFfffedb)), // Borda quando não está focado
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF38c958)), // Borda quando está focado
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _selectedCategory,
              items: <String>['Todos', 'Ação', 'Comédia', 'Drama', 'Sci-Fi', 'Terror']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFF149C68)), // Alterada para #149C68
                  ), // Aplicando a fonte
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _filterByCategory();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRecommendations.length,
              itemBuilder: (context, index) {
                final movie = _filteredRecommendations[index];
                return Card(
                  color: const Color(0xFF383939),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(movie['titulo']!, style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFF149C68))),
                    subtitle: Text(movie['categoria']!, style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFF149C68))), // Alterada para #149C68
                    leading: _buildImage(movie['imagem']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteRecommendationPage(
                              movie: _filteredRecommendations[index],
                              onDelete: deleteRecommendation,
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: _filteredRecommendations[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null || !File(imagePath).existsSync()) {
      return const Icon(
        Icons.movie,
        size: 50,
        color: Colors.black87,
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.movie,
            size: 50,
            color: Colors.grey,
          );
        },
      );
    }
  }
}
