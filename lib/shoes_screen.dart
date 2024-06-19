import 'package:flutter/material.dart';
import 'package:proyecto/payment_screen.dart';

class ShoesScreen extends StatelessWidget {
  final List<Map<String, String>> shoes = [
    {'image': 'assets/shoes1.jpg', 'name': 'Zapato Rojo', 'price': '\$50.00'},
    {'image': 'assets/shoes2.jpg', 'name': 'Zapato Azul', 'price': '\$55.00'},
    {'image': 'assets/shoes3.jpg', 'name': 'Zapato Verde', 'price': '\$45.00'},
    {'image': 'assets/shoes4.jpg', 'name': 'Zapato Negro', 'price': '\$60.00'},
    {'image': 'assets/shoes5.jpg', 'name': 'Zapato Amarillo', 'price': '\$40.00'},
    {'image': 'assets/shoes6.jpg', 'name': 'Zapato Rosa', 'price': '\$42.00'},
  ];

  final List<Map<String, String>> cart;

  ShoesScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Zapatos'),
      ),
      body: _buildShoesGridView(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/projectDescription');
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Acción para Search
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(cart: cart),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShoesGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
      ),
      itemCount: shoes.length,
      itemBuilder: (context, index) {
        return _buildShoeItem(context, shoes[index]);
      },
    );
  }

  Widget _buildShoeItem(BuildContext context, Map<String, String> shoe) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              shoe['image']!,
              width: 150,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              shoe['name']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              shoe['price']!,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                cart.add(shoe);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${shoe['name']} agregado al carrito'),
                  ),
                );
              },
              child: Text('Agregar al carrito'),
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(cart[index]['image']!),
                  title: Text(cart[index]['name']!),
                  trailing: Text(cart[index]['price']!),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentScreen(cart: cart)),);
              
            },
            child: Text('Comprar'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
