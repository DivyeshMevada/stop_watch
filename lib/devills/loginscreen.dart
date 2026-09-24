import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _isLoggedIn = false;
  String name = '';
  String email = '';
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 100),
        const SizedBox(height: 20),
        Text('welcome, $name!', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 10),
        Text('Email:$email', style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[\w.-]+@[\w-]+(\.[\w-]+)+$');
                if (!emailRegex.hasMatch(text.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _validate, child: const Text('Login')),
          ],
        ),
      ),
    );
  }

  void _validate() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoggedIn = true;
        name = _nameController.text.trim();
        email = _emailController.text.trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(child: _isLoggedIn ? _buildSuccess() : _buildLoginForm()),
    );
  }
}






















// create a registration form with following inf field 1. user name (validation) st ct 2. email (validation) st ct 3.password (validate 10 char ,3 capital , 3 small, 2 numbers ,2 special char) st ct 4. re enter password (validate with password)st ct  5. gender (radio -male/ female)st 6.qualification(checkbox - 10th,12th .graduate) st 7. city (dropdoen - city1/city2,city3)st 8. height (slider 48 inch to 84 inch)st 9. date of birth (date time picker) st 10. submit botton  when user clicks on submit button,valdate all data and redirect user to next widget display all user entered information into next widget