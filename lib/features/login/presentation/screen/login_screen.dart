import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rostoms_app/core/routes/app_routes.dart';
import 'package:rostoms_app/features/login/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: "rostom825@gmail.com");
  final _passwordController = TextEditingController(text: "Just press login");
  final _formKey = GlobalKey<FormState>();

  Future<void> _onLogin() async {
    context.pushReplacementNamed(AppRoutes.productScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 92, left: 24, right: 24, bottom: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Welcome back.!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 32),

                  CustomTextField(
                    hintText: "Email",
                    textEditingController: _emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Password",
                    textEditingController: _passwordController,
                    isPassword: true,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password?"),
                    ),
                  ),
                  ElevatedButton(onPressed: _onLogin, child: Text("Login")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
