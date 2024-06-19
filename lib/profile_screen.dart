import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  String nombre = 'Erika';
  String apellido = 'Apellido';
  String email = 'Erika@example.com';

  int edad = 30;

 
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController edadController = TextEditingController();

 
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
   
    nombreController.text = nombre;
    apellidoController.text = apellido;
    emailController.text = email;
    edadController.text = edad.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 240, 255),
              Color.fromARGB(255, 230, 240, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildProfileItem('Nombre', nombreController),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: _buildProfileItem('Apellido', apellidoController),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildProfileItem('Email', emailController),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: _buildProfileItem('Edad', edadController),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), 
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: label == 'usuario', 
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              
              _updateUserData(label, controller.text);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
            
              _deleteUserData(label);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _updateUserData(String field, String value) async {
    try {
      // Actualizar el users
      if (field == 'Nombre') {
        await usersCollection.doc('user_id').update({'nombre': value});
      } else if (field == 'Apellido') {
        await usersCollection.doc('user_id').update({'apellido': value});
      } else if (field == 'Edad') {
        int edadValue = int.tryParse(value) ?? 0;
        await usersCollection.doc('user_id').update({'edad': edadValue});
      }

      //mensaje exito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$field actualizado en Firestore'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
    
      print('Error updating user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar $field'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _deleteUserData(String field) async {
    try {
      // Eliminar 
      if (field == 'Nombre') {
        await usersCollection.doc('user_id').update({'nombre': FieldValue.delete()});
        nombreController.text = ''; // Limpiar el controlador local también
      } else if (field == 'Apellido') {
        await usersCollection.doc('user_id').update({'apellido': FieldValue.delete()});
        apellidoController.text = ''; // Limpiar el controlador local también
      } else if (field == 'Edad') {
        await usersCollection.doc('user_id').update({'edad': FieldValue.delete()});
        edadController.text = ''; // Limpiar el controlador local también
      }

      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$field eliminado de Firestore'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      
      print('Error deleting user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al eliminar $field'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
