import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void goTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4E7F4),
      appBar: AppBar(
        title: const Text(
          "FASHIONIST",
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
            letterSpacing: 1.5,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF4E7F4),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFB497BD)),
              child: Text(
                'Welcome to Fashionist!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add, color: Color(0xFF6A1B9A)),
              title: const Text('Add Product'),
              onTap: () => goTo(context, '/add'),
            ),
            ListTile(
              leading: const Icon(Icons.view_list, color: Color(0xFF6A1B9A)),
              title: const Text('View Products'),
              onTap: () => goTo(context, '/view'),
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF6A1B9A)),
              title: const Text('Edit Product'),
              onTap: () => goTo(context, '/edit'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enhance your fashion sense with FASHIONIST!",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C3C6D),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Discover the latest trends in fashion, find your favorite items, and enjoy a personalized shopping experience.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Products Available",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C3C6D),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  categoryCard(
                    "Shoes",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOQOnhJMAqpVzPYJLviZg9sPIhWuNioqjd9g&s",
                  ),
                  categoryCard(
                    "Clothing",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwJWILte5-zfYj7fNK_E9ygudB0FgJ37RNRQ&s",
                  ),
                  categoryCard(
                    "Accessories",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLjHOY0lpLXfGR3AYxbLJuYq4hK0v0G2Vn_g&s",
                  ),
                  categoryCard(
                    "Watches",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPY8lGocWsTgXzIeB39PZ_KYjNo-qlW7W_QQ&s",
                  ),
                  categoryCard(
                    "Bags",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxuiFjgMYMWGBO1QIfFKqT3IjfMrRMpSyFuA&s",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Best Sellers",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Times New Roman',
                color: Color(0xFF5C3C6D),
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwJWILte5-zfYj7fNK_E9ygudB0FgJ37RNRQ&s",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Explore more on current trends!",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFB497BD).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'POPULAR SEARCHES',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nike  Puma  Adidas  Fila  Lee  United Colors of Benetton  Wrangler  Fastrack  Woodland  Yepme  Levis  Tommy Hilfiger  peter-england  fabindia  nike shoes  tops  shirts  jackets  myntra coupons  kurtis  shoes  tunics  dresses  Watches  saree  kurtas  bags  T-shirts  designer saree  sunglasses  jeans  trousers  adidas shoes  casual shoes  sports shoes  fastrack watches  ethnic wear  woodland-shoes  mobile app  puma shoes  accessories  anarkali suit  running shoes  reebok  formal wear  cat  jewellery',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF5C3C6D),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(color: Color(0xFF6A1B9A)),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'In case of any concern, Contact Us\n© 2025 www.fashionist.com. All rights reserved.\nFashionist team',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Color(0xFF5C3C6D)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget categoryCard(String title, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5C3C6D),
            ),
          ),
        ],
      ),
    );
  }
}
