import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agree = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                label: const Text('Back'),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                "Create Account",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                "Sign up to get started with HydroSense",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Full Name", "Enter your full name"),
                    const SizedBox(height: 16),
                    _buildTextField("Email Address", "Enter your email"),
                    const SizedBox(height: 16),
                    _buildPasswordField("Password", _obscurePassword, (v) {
                      setState(() => _obscurePassword = !_obscurePassword);
                    }),
                    const SizedBox(height: 16),
                    _buildPasswordField("Confirm Password", _obscureConfirm, (v) {
                      setState(() => _obscureConfirm = !_obscureConfirm);
                    }),
                    const SizedBox(height: 16),

                    // Checkbox and Terms
                    Row(
                      children: [
                        Checkbox(
                          value: _agree,
                          onChanged: (val) {
                            setState(() => _agree = val ?? false);
                          },
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              const Text("I agree to the "),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Terms of Service",
                                  style: TextStyle(color: Colors.blue[700]),
                                ),
                              ),
                              const Text(" and "),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(color: Colors.blue[700]),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _agree ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor:
                          _agree ? Colors.blueAccent : Colors.blue[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Or sign up with"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          label: "Google",
                          color: Colors.white,
                          borderColor: Colors.grey[300],
                        ),
                        _buildSocialButton(
                          icon: Icons.facebook,
                          label: "Facebook",
                          color: Colors.white,
                          borderColor: Colors.grey[300],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Already have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        ),
                      ],
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

  // Input Fields
  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(
      String label, bool obscure, void Function(bool) onToggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: "Create a password",
            contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => onToggle(!obscure),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    Color? color,
    Color? borderColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: borderColor ?? Colors.grey),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: Icon(icon, color: Colors.black54),
          label: Text(
            label,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
