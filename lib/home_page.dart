import 'package:flutter/material.dart';
import 'add_recommendation_page.dart';
import 'movie_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> recommendations = [];

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
  }

  void addRecommendation(Map<String, String> movie) {
    setState(() {
      recommendations.add(movie);
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
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xFF383939),
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(recommendations[index]['titulo']!, style: TextStyle(color: Color(0xFF149C68))),
              subtitle: Text(recommendations[index]['categoria']!, style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: recommendations[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
