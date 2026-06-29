import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final nomorController = TextEditingController();
  final passwordController = TextEditingController();
  final konfirmasiController = TextEditingController();

  final ApiService apiService = ApiService();

  bool isChecked = false;

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

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.title,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.title,
                ),
              ),

              const SizedBox(height: 28),

              ClipOval(
                child: Image.asset(
                "assets/images/register_logo.png",
                width: 145,
                height: 145,
                fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 32),

              CustomTextField(
                label: "Nama Lengkap",
                hintText: "Masukkan nama lengkap",
                controller: namaController,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: "Email",
                hintText: "contoh@email.com",
                controller: emailController,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: "Nomor HP",
                hintText: "0812xxxxxxx",
                controller: nomorController,
              ),

              const SizedBox(height: 20),

CustomTextField(
  label: "Password",
  hintText: "Masukkan kata sandi",
  controller: passwordController,
  isPassword: true,
),

const SizedBox(height: 20),

CustomTextField(
  label: "Konfirmasi Password",
  hintText: "Masukkan kembali kata sandi",
  controller: konfirmasiController,
  isPassword: true,
),

const SizedBox(height: 20),

Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Checkbox(
      value: isChecked,
      activeColor: AppColors.primary,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
        });
      },
    ),

    Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: AppColors.text,
            ),
            children: [
              TextSpan(
                text: "Saya menyetujui ",
              ),
              TextSpan(
                text: "Syarat & Ketentuan",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 28),

CustomButton(
  text: "Daftar",
  onPressed: () async {
            // Validasi Nama
        if (namaController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nama lengkap tidak boleh kosong")),
            );
            return;
        }

        // Validasi Email
        if (emailController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email tidak boleh kosong")),
            );
            return;
        }

        // Validasi Nomor HP
        if (nomorController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nomor HP tidak boleh kosong")),
            );
            return;
        }

        // Validasi Password
        if (passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password tidak boleh kosong")),
            );
            return;
        }

        // Validasi Konfirmasi Password
        if (passwordController.text != konfirmasiController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Konfirmasi password tidak sama")),
            );
            return;
        }

        // Validasi Checkbox
        if (!isChecked) {
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Silakan setujui syarat & ketentuan"),
            ),
            );
            return;
        }

        final response = await apiService.registerUser(
            fullName: namaController.text.trim(),
            email: emailController.text.trim(),
            phone: nomorController.text.trim(),
            password: passwordController.text,
        );

        if (response.statusCode == 201) {

            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Registrasi berhasil"),
            ),
            );

            Navigator.pop(context);

        } else {

            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Registrasi gagal"),
            ),
            );
        }
  },
),

const SizedBox(height: 28),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    const Text(
      "Sudah punya akun? ",
      style: TextStyle(
        color: AppColors.text,
      ),
    ),

    GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Text(
        "Masuk di sini",
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