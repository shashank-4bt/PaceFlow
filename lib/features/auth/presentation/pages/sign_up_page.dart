import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacings.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_auth_button.dart';
import 'sign_in_page.dart';

/// Email/password registration screen.
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  static const routePath = '/auth/sign-up';
  static const routeName = 'signUp';

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final success = await ref.read(authControllerProvider.notifier).signUp(
          email: _emailController.text,
          password: _passwordController.text,
          displayName: _displayNameController.text,
        );
    if (!mounted) {
      return;
    }
    if (success) {
      context.go('/');
    }
  }

  Future<void> _signInWithGoogle() async {
    final success =
        await ref.read(authControllerProvider.notifier).signInWithGoogle();
    if (!mounted) {
      return;
    }
    if (success) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    ref.listen(authControllerProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
        ref.read(authControllerProvider.notifier).clearError();
      }
    });

    return AuthScaffold(
      title: 'Create account',
      subtitle: 'Join PaceFlow and start tracking your walks.',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: theme.textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: authState.isLoading
                ? null
                : () => context.go(SignInPage.routePath),
            child: const Text('Sign in'),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              controller: _displayNameController,
              label: 'Display name',
              hint: 'How should we call you?',
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.person_outline,
              validator: Validators.displayName,
            ),
            const SizedBox(height: AppSpacings.lg),
            AuthTextField(
              controller: _emailController,
              label: 'Email',
              hint: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.email_outlined,
              autocorrect: false,
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacings.lg),
            AuthTextField(
              controller: _passwordController,
              label: 'Password',
              hint: 'At least 8 characters',
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              prefixIcon: Icons.lock_outline,
              autocorrect: false,
              validator: Validators.password,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            const SizedBox(height: AppSpacings.lg),
            AuthTextField(
              controller: _confirmPasswordController,
              label: 'Confirm password',
              hint: 'Re-enter your password',
              obscureText: _obscureConfirm,
              textInputAction: TextInputAction.done,
              prefixIcon: Icons.lock_outline,
              autocorrect: false,
              validator: (value) => Validators.confirmPassword(
                value,
                _passwordController.text,
              ),
              onFieldSubmitted: (_) => _submit(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
            ),
            const SizedBox(height: AppSpacings.xl),
            ElevatedButton(
              onPressed: authState.isLoading ? null : _submit,
              child: authState.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text('Create account'),
            ),
            const SizedBox(height: AppSpacings.lg),
            Row(
              children: [
                Expanded(child: Divider(color: theme.dividerColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacings.md),
                  child: Text('or', style: theme.textTheme.bodySmall),
                ),
                Expanded(child: Divider(color: theme.dividerColor)),
              ],
            ),
            const SizedBox(height: AppSpacings.lg),
            SocialAuthButton(
              provider: SocialAuthProvider.google,
              isLoading: authState.isLoading,
              onPressed: _signInWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
