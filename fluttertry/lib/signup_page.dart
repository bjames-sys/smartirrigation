import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;

  bool isLengthValid = false;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void _validatePassword(String value) {
    setState(() {
      isLengthValid = value.length >= 8 && value.length <= 20;
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasNumber = value.contains(RegExp(r'[0-9]'));
      hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.black87),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0084FF),
                  ),
                ),
                const SizedBox(height: 32),

                const Text('Full Name',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        controller: _firstNameController,
                        hint: 'First Name',
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        controller: _lastNameController,
                        hint: 'Last Name',
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const Text('Contact No.',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 8),
                _buildField(
                  controller: _contactController,
                  hint: 'Contact Number',
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),

                const Text('Email',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 8),
                _buildField(
                  controller: _emailController,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (!v.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text('Password',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 8),
                _buildPasswordField(
                  controller: _passwordController,
                  hint: 'Password',
                  isVisible: showPassword,
                  onChanged: _validatePassword,
                  onVisibilityToggle: () {
                    setState(() => showPassword = !showPassword);
                  },
                  validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20),

                const Text('Confirm Password',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                const SizedBox(height: 8),
                _buildPasswordField(
                  controller: _confirmController,
                  hint: 'Confirm Password',
                  isVisible: showConfirmPassword,
                  onVisibilityToggle: () {
                    setState(() => showConfirmPassword = !showConfirmPassword);
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (v != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                const Text(
                  'YOUR PASSWORD MUST CONTAIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _passwordRule('Between 8 and 20 characters', isLengthValid),
                _passwordRule('1 upper case letter', hasUppercase),
                _passwordRule('1 or more numbers', hasNumber),
                _passwordRule('1 or more special character', hasSpecialChar),
                const SizedBox(height: 32),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0084FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),
        filled: true,
        fillColor: const Color(0xFFF1F1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required void Function() onVisibilityToggle,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),
        filled: true,
        fillColor: const Color(0xFFF1F1F1),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.black54,
          ),
          onPressed: onVisibilityToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _passwordRule(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(Icons.circle,
              color: isValid ? Colors.green : Colors.grey.shade400, size: 10),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isValid ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
