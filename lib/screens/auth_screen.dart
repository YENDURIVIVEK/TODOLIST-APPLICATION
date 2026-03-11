import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _loginKey = GlobalKey<FormState>();
  final _signupKey = GlobalKey<FormState>();

  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();

  final TextEditingController signupName = TextEditingController();
  final TextEditingController signupEmail = TextEditingController();
  final TextEditingController signupPassword = TextEditingController();

  bool obscureLogin = true;
  bool obscureSignup = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> signUp() async {
    if (_signupKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> user = {
        "name": signupName.text,
        "email": signupEmail.text,
        "password": signupPassword.text,
      };

      String userJson = jsonEncode(user);

      await prefs.setString("user", userJson);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup Successful")));

      _tabController.animateTo(0);
    }
  }

  Future<void> login() async {
    if (_loginKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userData = prefs.getString("user");

      if (userData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found. Please signup.")),
        );
        return;
      }

      Map<String, dynamic> user = jsonDecode(userData);

      if (loginEmail.text == user["email"] &&
          loginPassword.text == user["password"]) {
        Navigator.pushReplacementNamed(context, "/dashboard");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
      }
    }
  }

  Widget buildLogin() {
    return Form(
      key: _loginKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Icon(Icons.task_alt, size: 80, color: Colors.blue),

            const SizedBox(height: 20),

            TextFormField(
              controller: loginEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "Enter email" : null,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: loginPassword,
              obscureText: obscureLogin,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureLogin ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureLogin = !obscureLogin;
                    });
                  },
                ),
              ),
              validator: (value) => value!.isEmpty ? "Enter password" : null,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: login,
                child: const Text("LOGIN"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignup() {
    return Form(
      key: _signupKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.person_add, size: 80, color: Colors.green),

            const SizedBox(height: 20),

            TextFormField(
              controller: signupName,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "Enter name" : null,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: signupEmail,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "Enter email" : null,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: signupPassword,
              obscureText: obscureSignup,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureSignup ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureSignup = !obscureSignup;
                    });
                  },
                ),
              ),
              validator: (value) =>
                  value!.length < 6 ? "Password must be 6 characters" : null,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: signUp,
                child: const Text("SIGN UP"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "LOGIN"),
            Tab(text: "SIGNUP"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [buildLogin(), buildSignup()],
      ),
    );
  }
}
