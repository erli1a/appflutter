import 'package:flutter/material.dart';

class PaymentFormScreen extends StatelessWidget {
  final double totalPrice;

  PaymentFormScreen({required this.totalPrice});

  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Pago'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            height: 400,
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _cardNumberController,
                        decoration: InputDecoration(labelText: 'Número de Tarjeta'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el número de tarjeta';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _expiryDateController,
                        decoration: InputDecoration(labelText: 'Fecha de Expiración'),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la fecha de expiración';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cvvController,
                        decoration: InputDecoration(labelText: 'CVV'),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el CVV';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Pago Exitoso'),
                                  content: Text('El pago de \$${totalPrice.toStringAsFixed(2)} se realizó con éxito.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, '/projectDescription');
                                      },
                                      child: Text('Aceptar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('Pagar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
