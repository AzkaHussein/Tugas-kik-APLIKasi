import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/social_login_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //tadi FormKey mnjadi FormState
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // TODO: Integrate with API
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pushReplacementNamed('/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Top Banner with recycling logo ──
              _buildTopBanner(size),

              // ── Login Card ──
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),

                    // Title & Subtitle
                    const Text(
                      'Masuk Ke Akun',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Selamat Datang Kembali!',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textGrey,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email atau nomor telepon',
                      prefixAsset: 'assets/icons/ic_email.png',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixAsset: 'assets/icons/ic_password.png',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppTheme.textGrey,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Masuk Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Divider: "Atau Masuk Dengan"
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: AppTheme.borderGrey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Atau Masuk Dengan',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textGrey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: AppTheme.borderGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialLoginButton(
                          assetPath: 'assets/icons/ic_google.png',
                          onTap: () {
                            // TODO: Google login
                          },
                        ),
                        const SizedBox(width: 16),
                        SocialLoginButton(
                          assetPath: 'assets/icons/ic_apple.png',
                          onTap: () {
                            // TODO: Apple login
                          },
                        ),
                        const SizedBox(width: 16),
                        SocialLoginButton(
                          assetPath: 'assets/icons/ic_phone.png',
                          onTap: () {
                            // TODO: Phone login
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Register Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Belum Punya Akun? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textGrey,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              TextSpan(
                                text: 'Daftar Sekarang',
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryGreen,
                                ),
                              ),
                            ],
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

  Widget _buildTopBanner(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.30,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (forest/green background)
          Image.asset(
            'assets/images/login_banner.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1B5E20),
                      Color(0xFF2E7D32),
                      Color(0xFF388E3C),
                    ],
                  ),
                ),
              );
            },
          ),
          // Recycling logo overlay
          // Center(
          //   child: Image.asset(
          //     'assets/images/recycle_logo_white.png',
          //     width: 120,
          //     height: 120,
          //     errorBuilder: (context, error, stackTrace) {
          //       return Container(
          //         width: 100,
          //         height: 100,
          //         decoration: BoxDecoration(
          //           color: Colors.white.withOpacity(0.15),
          //           shape: BoxShape.circle,
          //         ),
          //         child: const Icon(
          //           Icons.recycling_rounded,
          //           color: Colors.white,
          //           size: 60,
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

