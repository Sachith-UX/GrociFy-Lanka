import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../auth/data/auth_provider.dart';

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
      final phoneNumber = '+94${_phoneController.text}';
      await ref.read(authProvider.notifier).sendOTP(phoneNumber);

      if (mounted) {
        context.go('/otp', extra: phoneNumber);
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
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    final phoneValidation = Validators.validatePhoneNumber(value);
                    if (phoneValidation != null) return phoneValidation;

                    // Remove country code for validation
                    final cleanNumber = value!.startsWith('+94')
                        ? value.substring(3)
                        : value.startsWith('0')
                            ? value.substring(1)
                            : value;

                    return Validators.validatePhoneNumber(cleanNumber);
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
                Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}