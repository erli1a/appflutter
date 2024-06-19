import 'package:flutter/material.dart';
import 'package:proyecto/payment_form_screen.dart';

class PaymentScreen extends StatelessWidget {
  final List<Map<String, String>> cart;

  PaymentScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(0.0, (sum, item) => sum + double.parse(item['price']!.substring(1)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentFormScreen(totalPrice: totalPrice),
                  ),
                );
              },
              child: Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}
