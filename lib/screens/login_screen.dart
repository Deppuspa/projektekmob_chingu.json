import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/google_button.dart';
import 'register_screen.dart';
import '../services/api_service.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(

          physics: const BouncingScrollPhysics(),

          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 22,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              const SizedBox(height: 18),

              Image.asset(
                "assets/images/logo.png",
                width: 115,
              ),

              const SizedBox(height: 8),

              const Text(
                "SaveBite",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title,
                  letterSpacing: .3,
                ),
              ),

              const SizedBox(height: 32),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Selamat Datang!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Selamatkan makanan,\nselamatkan bumi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.text,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              CustomTextField(
                label: "Email",
                hintText: "nama@email.com",
                controller: emailController,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: "Password",
                hintText: "Masukkan kata sandi",
                controller: passwordController,
                isPassword: true,
              ),
const SizedBox(height: 12),

Align(
  alignment: Alignment.centerRight,
  child: GestureDetector(
    onTap: () {},
    child: const Text(
      "Lupa Password?",
      style: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),

const SizedBox(height: 28),

CustomButton(
  text: "Masuk",
  onPressed: () async {
        if (emailController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
          content: Text("Email tidak boleh kosong"),
        ),
      );
      return;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak boleh kosong"),
        ),
      );
      return;
    }
    final users = await apiService.getUsers();

    final user = users.cast<Map<String, dynamic>>().firstWhere(
      (user) =>
      user["email"] == emailController.text.trim() &&
      user["password"] == passwordController.text.trim(),
      orElse: () => {},
    );
    if (user.isNotEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login berhasil"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
        content: Text("Email atau password salah"),
      ),
    );
  }
  },
),

const SizedBox(height: 28),

Row(
  children: const [
    Expanded(child: Divider()),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("atau"),
    ),
    Expanded(child: Divider()),
  ],
),

const SizedBox(height: 28),

GoogleButton(
  onPressed: () {},
),

const SizedBox(height: 28),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      "Belum punya akun? ",
      style: TextStyle(
        color: AppColors.text,
      ),
    ),
    GestureDetector(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    },
      child: const Text(
        "Daftar di sini",
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}