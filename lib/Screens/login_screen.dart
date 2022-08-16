import 'package:cannes/app_colors.dart';
import 'package:flutter/material.dart';

import '../Widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Cannes",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: 'HandM',
                  fontSize: 75,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              textEditingController: _passwordController,
              label: "Password",
              isObscure: true,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
