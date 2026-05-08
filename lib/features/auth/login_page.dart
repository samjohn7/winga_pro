import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/router/route_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 🇹🇿 TANZANIA PHONE VALIDATION
  bool isValidTzNumber(String phone) {
    final regex = RegExp(r'^(\+255|0)[67]\d{8}$');
    return regex.hasMatch(phone);
  }

  Future<void> loginUser() async {

  String phone = phoneController.text.trim();
  String password = passwordController.text.trim();

  // EMPTY CHECK
  if (phone.isEmpty || password.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields"),
      ),
    );

    return;
  }

  // PHONE VALIDATION
  if (!isValidTzNumber(phone)) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Enter valid Tanzanian number"),
      ),
    );

    return;
  }

  try {

    final url = Uri.parse(
      "http://192.168.18.172:3000/api/auth/login",
    );

    final response = await http.post(

      url,

      headers: {
        "Content-Type": "application/json",
      },

      body: jsonEncode({

        "phone": phone,
        "password": password,

      }),
    );

    final data = jsonDecode(response.body);

    // SUCCESS
    if (response.statusCode == 200) {

      String role = data["user"]["role"];

      // CUSTOMER
      if (role == "customer") {

        Navigator.pushReplacementNamed(
          context,
          RouteNames.customerHome,
        );

      }

      // PRODUCER
      else if (role == "producer") {

        // CHECK APPROVAL
        bool verified = data["user"]["is_verified"];

        if (!verified) {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Your account is waiting admin approval",
              ),
            ),
          );

          return;
        }

        Navigator.pushReplacementNamed(
          context,
          RouteNames.producerHome,
        );

      }

      // ADMIN
      else if (role == "admin") {

        Navigator.pushReplacementNamed(
          context,
          RouteNames.adminDashboard,
        );

      }

    }

    // FAILED LOGIN
    else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"]),
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
}  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Winga Pro Login"),
      ),

      body: SafeArea(
        child: Container(
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
                    color: Colors.white.withOpacity(0.9),
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
                          Icons.wifi,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Winga Pro",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        "Buy & Sell Internet Packages",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // PHONE FIELD
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

                      // PASSWORD FIELD
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

                      const SizedBox(height: 25),

                      // LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loginUser,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),

                          child: const Text(
                            "SIGN IN",
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
                          Navigator.pushNamed(
                            context,
                            RouteNames.register,
                          );
                        },

                        child: const Text(
                          "Create new account",
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
      ),
    );
  }
}