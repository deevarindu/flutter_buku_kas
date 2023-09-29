import 'package:flutter/material.dart';
import 'package:flutter_buku_kas/models/user_model.dart';
import 'package:flutter_buku_kas/services/database_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  void _login() async {
    final userLogin = UserModel(username: "user", password: "user");
    await DatabaseHelper.addUser(userLogin);

    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Username dan password tidak boleh kosong.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final user = await DatabaseHelper.loginUser(username, password);

    if (user != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username atau password salah.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 100, bottom: 20, left: 20, right: 20),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/login.png",
                          width: MediaQuery.of(context).size.width * 0.75,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'MyCashBook v1.0',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.075,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            labelText: "Username",
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onSaved: (value) {
                            username = value!;
                          },
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            suffixIcon: IconButton(
                              padding: EdgeInsets.all(16),
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 80, 194, 201),
                          ),
                        ),
                        onPressed: () {
                          _login();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
