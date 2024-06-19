import 'package:flutter/material.dart';
import 'package:proyecto/payment_screen.dart';
import 'package:proyecto/shoes_screen.dart';
import 'dresses_screen.dart'; 

class ProjectDescriptionScreen extends StatefulWidget {
  @override
  _ProjectDescriptionScreenState createState() =>
      _ProjectDescriptionScreenState();
}

class _ProjectDescriptionScreenState extends State<ProjectDescriptionScreen> {
  List<Map<String, String>> _cart = [];

  void _showCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: _cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descripción del Proyecto'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 177, 192),
                    Color.fromRGBO(255, 231, 231, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/perfil.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Erika', // Cambia el nombre de usuario aquí
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pushNamed(context, '/projectDescription'); 
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrito de Compras'),
              onTap: _showCart,
            ),
            
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favoritos'),
              onTap: () {
                // Acción al presionar "Favoritos"
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () {
               Navigator.pushNamed(context, '/profile'); 
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
               
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushNamed(context, '/'); 
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '¡Hola Erika!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              _buildClothingCarousel(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem('assets/shoes.jpg', 'Zapatos'),
                  _buildCategoryItem('assets/dress.jpg', 'Vestidos'),
                  _buildCategoryItem('assets/blouse.jpg', 'Blusas'),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Productos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              _buildProductGrid(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectDescriptionScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
               
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: _showCart,
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildCategoryItem(String imagePath, String label) {
  return GestureDetector(
    onTap: () {
      if (label == 'Vestidos') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DressesScreen(cart: _cart)),
        );
      } else if (label == 'Zapatos') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShoesScreen(cart: [],)), 
        );
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 252, 152, 172),
            Color.fromRGBO(255, 209, 209, 1),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 140,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildProductItem(index);
      },
    );
  }

 Widget _buildProductItem(int index) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/product_$index.png',
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Producto $index',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, 
        ),
        Text(
          '\$20.00',
          style: TextStyle(
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center, 
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
           
            setState(() {
              _cart.add({
                'image': 'assets/product_$index.png',
                'name': 'Producto $index',
                'price': '\$20.00',
              });
            });

         
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Producto $index agregado al carrito'),
                duration: Duration(seconds: 2), 
              ),
            );
          },
          child: Text('Agregar al carrito'),
        ),
      ],
    ),
  );
}


  Widget _buildClothingCarousel() {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildClothingItem('assets/shoes.jpg'),
          SizedBox(width: 120),
          _buildClothingItem('assets/dress.jpg'),
          SizedBox(width: 120),
          _buildClothingItem('assets/blouse.jpg'),
          SizedBox(width: 120),
          _buildClothingItem('assets/blazer.jpg'),
          SizedBox(width: 120),
          _buildClothingItem('assets/chica.jpg'),
          SizedBox(width: 120),
          _buildClothingItem('assets/jeans.jpg'),
        ],
      ),
    );
  }

  Widget _buildClothingItem(String imagePath) {
    return Container(
      width: 400,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
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
