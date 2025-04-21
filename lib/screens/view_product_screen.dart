import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  List<Product> products = [];
  String selectedCategory = '';

  Future<void> fetchProducts() async {
    final result = await ApiService.getProducts();
    setState(() {
      products = result;
    });
  }

  Future<void> deleteProduct(String id) async {
    await ApiService.deleteProduct(id);
    fetchProducts();
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void showProductDetails(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF4E7F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      '${ApiService.baseUrl}${product.imageUrl}',
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 10),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text("₹${product.price}", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                ...?product.description
                    ?.split('\n')
                    .map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(line, style: const TextStyle(fontSize: 14)),
                      ),
                    ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Close",
                style: TextStyle(color: Color(0xFF6A1B9A)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        selectedCategory.isEmpty
            ? products
            : products
                .where(
                  (p) =>
                      p.description?.toLowerCase().contains(
                        selectedCategory.toLowerCase(),
                      ) ??
                      false,
                )
                .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4E7F4),
      appBar: AppBar(
        title: const Text("View Products"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: '', child: Text("All")),
                  const PopupMenuItem(value: 'shoes', child: Text("Shoes")),
                  const PopupMenuItem(
                    value: 'clothing',
                    child: Text("Clothing"),
                  ),
                  const PopupMenuItem(
                    value: 'accessories',
                    child: Text("Accessories"),
                  ),
                ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final p = filteredProducts[index];
            return InkWell(
              onTap: () => showProductDetails(p),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (p.imageUrl != null)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          '${ApiService.baseUrl}${p.imageUrl}',
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                              color: Color(0xFF5C3C6D),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${p.price}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF6A1B9A),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit',
                              arguments: {
                                '_id': p.id,
                                'name': p.name,
                                'price': p.price,
                                'description': p.description,
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => deleteProduct(p.id!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
