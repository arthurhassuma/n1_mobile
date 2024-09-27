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
    // Seleciona a imagem da galeria
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // Armazena o caminho completo da imagem para uso com Image.file
        selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Recomendações'),
        backgroundColor: const Color(0xFF149C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título do Filme'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição do Filme'),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Selecionar Imagem'),
            ),
            if (selectedImagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.file(
                  File(selectedImagePath!), // Exibe a imagem selecionada
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
                  'imagem': selectedImagePath ?? '', // Certifica-se de que não seja nulo
                });
                Navigator.pop(context);
              },
              child: const Text('Adicionar Filme'),
            ),
          ],
        ),
      ),
    );
  }
}
