import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario en Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.blueAccent),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Color de fondo del botón
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bordes redondeados
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: FormularioScreen(),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>(); // Clave global del formulario
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Moderno'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Para evitar el overflow en pantallas pequeñas
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _nombreController,
                  label: 'Nombre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su nombre';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _emailController,
                  label: 'Correo Electrónico',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su correo';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Ingrese un correo válido';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Contraseña',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _telefonoController,
                  label: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su teléfono';
                    } else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                      return 'Ingrese un número de teléfono válido';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _direccionController,
                  label: 'Dirección',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su dirección';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Formulario válido')),
                      );
                    }
                  },
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir el campo de texto con estilo moderno
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
