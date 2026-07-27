import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacings.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_auth_button.dart';
import 'forgot_password_page.dart';
import 'sign_up_page.dart';

/// Email/password sign-in screen. Navigate with go_router paths.
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  static const routePath = '/auth/sign-in';
  static const routeName = 'signIn';

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final success = await ref.read(authControllerProvider.notifier).signIn(
          email: _emailController.text,
          password: _passwordController.text,
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
      title: 'Welcome back',
      subtitle: 'Sign in to continue your walking journey.',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: theme.textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: authState.isLoading
                ? null
                : () => context.push(SignUpPage.routePath),
            child: const Text('Sign up'),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              hint: 'Enter your password',
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              prefixIcon: Icons.lock_outline,
              autocorrect: false,
              validator: Validators.passwordRequired,
              onFieldSubmitted: (_) => _submit(),
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: authState.isLoading
                    ? null
                    : () => context.push(ForgotPasswordPage.routePath),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: AppSpacings.md),
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
                  : const Text('Sign in'),
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
