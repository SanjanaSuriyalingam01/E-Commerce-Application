import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/api_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  String selectedCategory = 'Shoes';
  PlatformFile? pickedImage;

  void pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pickedImage = result.files.first;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Image added!")));
    }
  }

  void addProduct() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    try {
      await ApiService.addProduct(
        nameController.text,
        double.parse(priceController.text),
        "$selectedCategory - ${descController.text}",
        pickedImage,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added product to $selectedCategory category!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      backgroundColor: const Color(0xFFF4E7F4),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB497BD),
              ),
              child: const Text(
                "Pick Image",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: const [
                DropdownMenuItem(value: 'Shoes', child: Text('Shoes')),
                DropdownMenuItem(value: 'Clothing', child: Text('Clothing')),
                DropdownMenuItem(
                  value: 'Accessories',
                  child: Text('Accessories'),
                ),
                DropdownMenuItem(value: 'Watches', child: Text('Watches')),
              ],
              onChanged: (value) => setState(() => selectedCategory = value!),
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB497BD),
              ),
              child: const Text(
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
