import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grocify/core/constants/app_sizes.dart';
import 'package:grocify/core/constants/app_strings.dart';
import 'package:grocify/core/utils/validators.dart';
import 'package:grocify/shared/widgets/custom_button.dart';
import 'package:grocify/shared/widgets/custom_text_field.dart';
import 'package:grocify/features/auth/data/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String rawPhone = _phoneController.text.trim();
      // Remove leading zero if present
      if (rawPhone.startsWith('0')) {
        rawPhone = rawPhone.substring(1);
      }
      // Ensure it doesn't already have +94
      if (rawPhone.startsWith('+94')) {
        // keep as is
      } else if (rawPhone.startsWith('94')) {
        rawPhone = '+$rawPhone';
      } else {
        rawPhone = '+94$rawPhone';
      }

      await ref.read(authProvider.notifier).sendOTP(rawPhone);

      if (mounted) {
        context.go('/otp', extra: rawPhone);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.xxl),

                // Header
                Text(
                  'Welcome to GrociFy',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSizes.sm),

                Text(
                  'Enter your phone number to continue',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: AppSizes.xxl),

                // Phone number field
                CustomTextField(
                  controller: _phoneController,
                  label: AppStrings.phoneNumber,
                  hint: '712345678',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('+94 ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    // Basic validation for Sri Lankan mobile number (9 digits after 0)
                    final cleanNumber = value.startsWith('0') ? value.substring(1) : value;
                    if (cleanNumber.length != 9) {
                      return 'Please enter a valid 9-digit number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSizes.xxl),

                // Continue button
                CustomButton(
                  text: 'Send OTP',
                  onPressed: _sendOTP,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: AppSizes.lg),

                // Terms and conditions
                Center(
                  child: Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}