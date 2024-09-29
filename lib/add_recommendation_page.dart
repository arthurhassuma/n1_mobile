import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecommendationPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  const AddRecommendationPage({super.key, required this.onAdd});

  @override
  _AddRecommendationPageState createState() => _AddRecommendationPageState();
}

class _AddRecommendationPageState extends State<AddRecommendationPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'Ação';
  String rating = '3';
  String? selectedImagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Recomendações', style: TextStyle(fontFamily: 'Proelium', color: Color(0xFFfffedb))),
        backgroundColor: const Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título do Filme',
                labelStyle: const TextStyle(color: Color(0xFFfffedb), fontFamily: 'Proelium'), // Cor do rótulo com a fonte
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFfffedb)), // Borda quando não está focado
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF38c958)), // Borda quando está focado
                ),
              ),
              style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFFfffedb)), // Cor do texto
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição do Filme',
                labelStyle: const TextStyle(color: Color(0xFFfffedb), fontFamily: 'Proelium'), // Cor do rótulo com a fonte
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFfffedb)), // Borda quando não está focado
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF38c958)), // Borda quando está focado
                ),
              ),
              maxLines: 3,
              style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFFfffedb)), // Cor do texto
            ),
            DropdownButton<String>(
              value: selectedCategory,
              dropdownColor: const Color(0xFFfffedb), // Cor de fundo do dropdown
              style: const TextStyle(color: Color(0xFF149C68)), // Cor do texto selecionado
              items: <String>['Ação', 'Comédia', 'Drama', 'Sci-Fi', 'Terror']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFF149C68)), // Cor do texto das opções
                  ),
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
              dropdownColor: const Color(0xFFfffedb), // Cor de fundo do dropdown
              style: const TextStyle(color: Color(0xFF149C68)), // Cor do texto selecionado
              items: <String>['0', '1', '2', '3', '4', '5']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(
                        'Nota: $value ',
                        style: const TextStyle(fontFamily: 'Proelium', color: Color(0xFF149C68)), // Cor do texto das opções
                      ),
                      // Ícones de estrela correspondendo ao número da nota
                      for (int i = 0; i < int.parse(value); i++)
                        const Icon(Icons.star, color: Color(0xFF149C68)), // Ícone de estrela
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  rating = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Selecionar Imagem', style: TextStyle(fontFamily: 'Proelium')), // Usando a fonte nova
            ),
            if (selectedImagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.file(
                  File(selectedImagePath!),
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onAdd({
                  'titulo': titleController.text,
                  'descricao': descriptionController.text,
                  'categoria': selectedCategory,
                  'nota': rating,
                  'imagem': selectedImagePath ?? '',
                });
                Navigator.pop(context);
              },
              child: const Text('Adicionar Filme', style: TextStyle(fontFamily: 'Proelium')), // Usando a fonte nova
            ),
          ],
        ),
      ),
    );
  }
}
