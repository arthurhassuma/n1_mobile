import 'package:flutter/material.dart';

class AddRecommendationPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  AddRecommendationPage({required this.onAdd});

  @override
  _AddRecommendationPageState createState() => _AddRecommendationPageState();
}

class _AddRecommendationPageState extends State<AddRecommendationPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'Ação';
  String rating = '3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Recomendações'),
        backgroundColor: Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título do Filme'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição do Filme'),
              maxLines: 3,
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: <String>['Ação', 'Comédia', 'Drama', 'Sci-Fi', 'Terror']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            DropdownButton<String>(
              value: rating,
              items: <String>['0', '1', '2', '3', '4', '5']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Nota: $value'),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  rating = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAdd({
                  'titulo': titleController.text,
                  'descricao': descriptionController.text,
                  'categoria': selectedCategory,
                  'nota': rating,
                });
                Navigator.pop(context);
              },
              child: Text('Adicionar Filme'),
            ),
          ],
        ),
      ),
    );
  }
}
