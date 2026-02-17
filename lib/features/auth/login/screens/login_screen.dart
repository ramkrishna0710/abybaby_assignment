import 'package:assignment_abybaby/core/utils/common_button.dart';
import 'package:assignment_abybaby/core/utils/input_text_field.dart';
import 'package:assignment_abybaby/domain/auth/auth_state/auth_state.dart';
import 'package:assignment_abybaby/route/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_helper.dart';
import '../../../../domain/auth/auth_bloc/auth_bloc.dart';
import '../../../../domain/auth/auth_event/auth_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'Enter your email here',
                      keyboardType: .emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!AppHelper.isValidEmail(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    InputTextField(
                      label: 'Password',
                      controller: _passController,
                      hintText: 'Enter your password here',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        // if (!AppHelper.isValidPassword(value)) {
                        //   return "Enter valid password";
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.isLoginSuccess) {
                          if(!mounted)return;
                          context.go(AppRoute.dealerNotificationListScreen);
                        }

                        if (state.loginError != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.loginError!)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CommonButton(
                          text: state.isLoginLoading ? "Loading..." : "Login",
                          onPressed: () {
                            if (state.isLoginLoading) {
                              return;
                            }
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            context.read<AuthBloc>().add(
                              LoginRequested(
                                email: _emailController.text.trim(),
                                password: _passController.text.trim(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Register now",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(AppRoute.register);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
