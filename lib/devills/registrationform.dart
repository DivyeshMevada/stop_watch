import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  String? gender;
  String city = 'City 1';
  double height = 48;

  DateTime? dob;

  bool tenth = false;
  bool twelfth = false;
  bool graduate = false;

  // Password validation:
  // 10 characters
  // 3 capital letters
  // 3 small letters
  // 2 numbers
  // 2 special characters
  bool validatePassword(String password) {
    int capitals = RegExp(r'[A-Z]').allMatches(password).length;
    int small = RegExp(r'[a-z]').allMatches(password).length;
    int numbers = RegExp(r'[0-9]').allMatches(password).length;
    int special = RegExp(r'[^A-Za-z0-9]').allMatches(password).length;

    return password.length >= 10 &&
        capitals >= 3 &&
        small >= 3 &&
        numbers >= 2 &&
        special >= 2;
  }

  String getQualification() {
    List<String> qualifications = [];

    if (tenth) qualifications.add('10th');
    if (twelfth) qualifications.add('12th');
    if (graduate) qualifications.add('Graduate');

    return qualifications.isEmpty ? 'Not Selected' : qualifications.join(', ');
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dob = pickedDate;
      });
    }
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (gender == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select gender')));
      return;
    }

    if (dob == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date of birth')),
      );
      return;
    }

    if (!tenth && !twelfth && !graduate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one qualification'),
        ),
      );
      return;
    }

    // Redirect to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          gender: gender!,
          qualification: getQualification(),
          city: city,
          height: height,
          dob: dob!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. USERNAME
              const Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter username',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Username is required';
                  }

                  if (value.length < 3) {
                    return 'Username must be at least 3 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 2. EMAIL
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(
                  hintText: 'Enter email',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 3. PASSWORD
              const Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              TextFormField(
                controller: passwordController,
                obscureText: true,

                decoration: const InputDecoration(
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  if (!validatePassword(value)) {
                    return 'Password must contain:\n'
                        '10+ characters, 3 capital, 3 small, '
                        '2 numbers and 2 special characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 4. RE-ENTER PASSWORD
              const Text(
                'Re-enter Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              TextFormField(
                controller: rePasswordController,
                obscureText: true,

                decoration: const InputDecoration(
                  hintText: 'Re-enter password',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please re-enter password';
                  }

                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // 5. GENDER
              const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              // 6. QUALIFICATION
              const Text(
                'Qualification',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              CheckboxListTile(
                title: const Text('10th'),
                value: tenth,
                onChanged: (value) {
                  setState(() {
                    tenth = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: const Text('12th'),
                value: twelfth,
                onChanged: (value) {
                  setState(() {
                    twelfth = value!;
                  });
                },
              ),

              CheckboxListTile(
                title: const Text('Graduate'),
                value: graduate,
                onChanged: (value) {
                  setState(() {
                    graduate = value!;
                  });
                },
              ),

              const SizedBox(height: 10),

              // 7. CITY
              const Text('City', style: TextStyle(fontWeight: FontWeight.bold)),

              DropdownButtonFormField<String>(
                value: city,

                decoration: const InputDecoration(border: OutlineInputBorder()),

                items: const [
                  DropdownMenuItem(value: 'City 1', child: Text('City 1')),
                  DropdownMenuItem(value: 'City 2', child: Text('City 2')),
                  DropdownMenuItem(value: 'City 3', child: Text('City 3')),
                ],

                onChanged: (value) {
                  setState(() {
                    city = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // 8. HEIGHT SLIDER
              Text(
                'Height: ${height.toInt()} inch',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              Slider(
                min: 48,
                max: 84,
                divisions: 36,
                value: height,

                label: '${height.toInt()} inch',

                onChanged: (value) {
                  setState(() {
                    height = value;
                  });
                },
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('48 inch'), Text('84 inch')],
              ),

              const SizedBox(height: 20),

              // 9. DATE OF BIRTH
              const Text(
                'Date of Birth',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              InkWell(
                onTap: selectDate,

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),

                  child: Text(
                    dob == null
                        ? 'Select Date of Birth'
                        : '${dob!.day}/${dob!.month}/${dob!.year}',
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 10. SUBMIT
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: submitForm,

                  child: const Text('SUBMIT', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// SECOND SCREEN
// =====================================================

class DisplayPage extends StatelessWidget {
  final String username;
  final String email;
  final String password;
  final String gender;
  final String qualification;
  final String city;
  final double height;
  final DateTime dob;

  const DisplayPage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.gender,
    required this.qualification,
    required this.city,
    required this.height,
    required this.dob,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Details')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Card(
          elevation: 5,

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'User Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const Divider(),

                Text('Username: $username'),

                const SizedBox(height: 10),

                Text('Email: $email'),

                const SizedBox(height: 10),

                // Password is displayed here because
                // the requirement says display all entered information.
                Text('Password: $password'),

                const SizedBox(height: 10),

                Text('Gender: $gender'),

                const SizedBox(height: 10),

                Text('Qualification: $qualification'),

                const SizedBox(height: 10),

                Text('City: $city'),

                const SizedBox(height: 10),

                Text('Height: ${height.toInt()} inch'),

                const SizedBox(height: 10),

                Text(
                  'Date of Birth: '
                  '${dob.day}/${dob.month}/${dob.year}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
