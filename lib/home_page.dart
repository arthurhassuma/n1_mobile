import 'package:flutter/material.dart';
import 'add_recommendation_page.dart';
import 'movie_detail_page.dart';
import 'delete_recommendation_page.dart';

class HomePage extends StatefulWidget {
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
    recommendations = [
      {
        'titulo': 'Filme A',
        'descricao': 'Descrição do Filme A',
        'categoria': 'Ação',
        'nota': '4',
      },
      {
        'titulo': 'Filme B',
        'descricao': 'Descrição do Filme B',
        'categoria': 'Comédia',
        'nota': '5',
      },
    ];
    _filteredRecommendations = recommendations;
  }

  void addRecommendation(Map<String, String> movie) {
    setState(() {
      recommendations.add(movie);
      _filteredRecommendations = recommendations;
    });
  }

  void deleteRecommendation(Map<String, String> movie) {
    setState(() {
      recommendations.remove(movie);
      _filteredRecommendations = recommendations;
    });
  }

  void _searchMovies() {
    setState(() {
      _filteredRecommendations = recommendations.where((movie) {
        return movie['titulo']?.toLowerCase().contains(_searchController.text?.toLowerCase() ?? '') ?? false;
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
        title: Text('Recomendações de Filmes', style: TextStyle(color: Color(0xFF149C68))),
        backgroundColor: Colors.black,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
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
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                backgroundColor: Color(0xFFfffedb),
                elevation: 5,
              ),
              child: Icon(Icons.add, color: Colors.black, size: 30),
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
              decoration: InputDecoration(
                labelText: 'Buscar filmes',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchMovies,
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
                  child: Text(value),
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
                  color: Color(0xFF383939),
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(movie['titulo']!, style: TextStyle(color: Color(0xFF149C68))),
                    subtitle: Text(movie['categoria']!, style: TextStyle(color: Colors.white70)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.black),
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
}
