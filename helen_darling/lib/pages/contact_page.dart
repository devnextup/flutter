import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensagem enviada com sucesso!')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  final Color primaryDark = const Color(0xFF9A9364);
  final Color primaryLight = const Color(0xFFA39F91);
  final Color backgroundColor = const Color(0xFFF6F1DD);
  final Color fieldColor = const Color(0xFFD7D2C1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text('Contato')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/header.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Entre em contato',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryDark,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, 'Nome'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      _emailController,
                      'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Digite seu e-mail';
                        if (!value.contains('@')) return 'E-mail inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      _messageController,
                      'Mensagem',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                            fontSize: 16,
                            color: fieldColor, // Texto na cor desejada
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator:
          validator ??
          (value) => value!.isEmpty ? 'Preencha o campo "$label"' : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: fieldColor,
        labelStyle: const TextStyle(color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryLight, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryLight),
        ),
      ),
    );
  }
}
