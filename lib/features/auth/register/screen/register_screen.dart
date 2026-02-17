import 'package:assignment_abybaby/core/utils/common_button.dart';
import 'package:assignment_abybaby/core/utils/input_text_field.dart';
import 'package:assignment_abybaby/route/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_helper.dart';
import '../../../../domain/auth/auth_bloc/auth_bloc.dart';
import '../../../../domain/auth/auth_event/auth_event.dart';
import '../../../../domain/auth/auth_state/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  final ValueNotifier<String> _genderNotifier = ValueNotifier<String>("");

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _genderNotifier.dispose();
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
                      label: 'Name',
                      controller: _nameController,
                      hintText: 'Enter your name here',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    InputTextField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'Enter your email here',
                      keyboardType: TextInputType.emailAddress,
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

                    FormField<String>(
                      validator: (value) {
                        if (_genderNotifier.value.isEmpty) {
                          return "Please select gender";
                        }
                        return null;
                      },
                      builder: (FormFieldState<String> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gender", style: theme.textTheme.bodyMedium),
                            const SizedBox(height: 6),
                            ValueListenableBuilder<String>(
                              valueListenable: _genderNotifier,
                              builder: (context, selectedGender, _) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: "Male",
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        _genderNotifier.value = value!;
                                        state.didChange(value);
                                      },
                                    ),
                                    const Text("Male"),
                                    Radio<String>(
                                      value: "Female",
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        _genderNotifier.value = value!;
                                        state.didChange(value);
                                      },
                                    ),
                                    const Text("Female"),
                                    Radio<String>(
                                      value: "Others",
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        _genderNotifier.value = value!;
                                        state.didChange(value);
                                      },
                                    ),
                                    const Text("Others"),
                                  ],
                                );
                              },
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  state.errorText!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    InputTextField(
                      label: 'Phone',
                      controller: _phoneController,
                      hintText: 'Enter your phone number',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone is required";
                        }
                        if (!AppHelper.isValidMobile(value)) {
                          return "Enter valid phone number";
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
                        //   return "Password must contain upper, lower, number & special char";
                        // }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.isRegisterSuccess) {
                          context.go(AppRoute.login);
                        }

                        if (state.registerError != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.registerError!)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CommonButton(
                          text: state.isRegisterLoading
                              ? "Loading..."
                              : "Register",
                          onPressed: () {
                            if (state.isRegisterLoading ||
                                !_formKey.currentState!.validate()) {
                              return;
                            }
                            context.read<AuthBloc>().add(
                              RegisterRequested(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                phone: _phoneController.text.trim(),
                                password: _passController.text.trim(),
                                gender: _genderNotifier.value,
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
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: "Login now",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(AppRoute.login);
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
