import 'package:flutter/material.dart';
import 'package:proyecto/payment_screen.dart';

class DressesScreen extends StatelessWidget {
  final List<Map<String, String>> dresses = [
    {'image': 'assets/dress1.jpg', 'name': 'Vestido Rojo', 'price': '\$30.00'},
    {'image': 'assets/dress2.jpg', 'name': 'Vestido Azul', 'price': '\$25.00'},
    {'image': 'assets/dress3.jpg', 'name': 'Vestido Verde', 'price': '\$28.00'},
    {'image': 'assets/dress4.jpg', 'name': 'Vestido Negro', 'price': '\$35.00'},
    {'image': 'assets/dress5.jpg', 'name': 'Vestido Amarillo', 'price': '\$20.00'},
    {'image': 'assets/dress6.jpg', 'name': 'Vestido Rosa', 'price': '\$22.00'},
  ];

  final List<Map<String, String>> cart;

  DressesScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vestidos'),
      ),
      body: _buildDressesGridView(), 
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

  Widget _buildDressesGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2, 
      ),
      itemCount: dresses.length,
      itemBuilder: (context, index) {
        return _buildDressItem(context, dresses[index]);
      },
    );
  }

  Widget _buildDressItem(BuildContext context, Map<String, String> dress) {
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
              dress['image']!,
              width: 150,
              height: 180, 
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dress['name']!,
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
              dress['price']!,
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
                cart.add(dress);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${dress['name']} agregado al carrito'),
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
                MaterialPageRoute(builder: (context) => PaymentScreen(cart: cart)),
              );
            },
            child: Text('Comprar'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
