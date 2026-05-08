import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/router/route_names.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedRole = "customer";

  Future<void> registerUser() async {

  String fullName = fullNameController.text.trim();
  String phone = phoneController.text.trim();
  String password = passwordController.text.trim();
  String confirmPassword = confirmPasswordController.text.trim();

  if (fullName.isEmpty ||
      phone.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields"),
      ),
    );

    return;
  }

  if (password != confirmPassword) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Passwords do not match"),
      ),
    );

    return;
  }

  try {

    final url = Uri.parse(
      "http://192.168.18.172:3000/api/auth/register",
    );

    final response = await http.post(

      url,

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "full_name": fullName,
        "phone": phone,
        "password": password,
        "role": selectedRole,

      }),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful"),
        ),
      );

      Navigator.pushReplacementNamed(
        context,
        RouteNames.login,
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.body),
        ),
      );

    }

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
      ),
    );

  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Account")),

     body: Container(
  width: double.infinity,
  height: double.infinity,

  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFEAF2FF),
        Color(0xFFF7F9FC),
      ],
    ),
  ),

  child: Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Container(
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              // ICON
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_add_alt_1,
                  size: 45,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Join Winga Pro Marketplace",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 25),

              // FULL NAME
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: const Color(0xFFF6F7FB),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // PHONE
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone_android),
                  filled: true,
                  fillColor: const Color(0xFFF6F7FB),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // PASSWORD
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: const Color(0xFFF6F7FB),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // CONFIRM PASSWORD
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: const Color(0xFFF6F7FB),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ROLE SELECT
              DropdownButtonFormField<String>(
                value: selectedRole,

                items: const [
                  DropdownMenuItem(
                    value: "customer",
                    child: Text("Customer"),
                  ),
                  DropdownMenuItem(
                    value: "producer",
                    child: Text("Producer"),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },

                decoration: InputDecoration(
                  labelText: "Select Role",
                  prefixIcon: const Icon(Icons.security),
                  filled: true,
                  fillColor: const Color(0xFFF6F7FB),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: registerUser,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),

                  child: const Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),
    );
  }
}
