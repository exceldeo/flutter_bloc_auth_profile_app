import 'package:flutter/material.dart';

import 'package:my_profile_app/core/components/textFormField/text_form_field.dart';
import 'package:my_profile_app/core/constants/app/string_constants.dart';
import 'package:my_profile_app/core/extensions/context_extensions.dart';
import 'package:my_profile_app/core/extensions/num_extensions.dart';
import 'package:my_profile_app/core/utils/validate_operations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_profile_app/core/base/auth/bloc/auth_bloc.dart';
import 'package:my_profile_app/core/components/button/button.dart';

import 'package:my_profile_app/core/constants/enums/auth_enums.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  bool? get validate => _formKey.currentState?.validate();

  Function checkValidate() {
    setState(() {});
    return () {};
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        // Check here if the state is unathenticated
        if (state.status == AuthStatus.authenticated) {
          // Navigate to Register page
          Navigator.pushReplacementNamed(context, '/');
        }
        if (state.error != null) {
          const snackBar = SnackBar(
            content: Text(
              "something went wrong!",
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();
          usernameController.clear();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.dynamicHeight(1),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidth(0.05),
              ),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Register",
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                      20.ph,
                      _EmailFormField(emailController: emailController),
                      _UsernameFormField(
                          usernameController: usernameController),
                      _PasswordFormField(
                          passwordController: passwordController),
                      _PasswordFormField(
                          passwordController: passwordConfirmController),
                      _RegisterButton(
                        isDisabled: !true,
                        onTap: () async {
                          if (passwordConfirmController.text.trim() !=
                              passwordController.text.trim()) {
                            const snackBar = SnackBar(
                              content: Text(
                                "passwords are not same!",
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }

                          if (validate != null && validate == true) {
                            context.read<AuthBloc>().add(RegisterRequested(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  usernameController.text.trim(),
                                ));
                          }
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have an account?",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: context.dynamicWidth(0.02),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                "Login here",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: Colors.yellow,
                                  decoration: TextDecoration.underline,
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
            ),
          ),
        ),
      ),
    );
  }
}
// Get the current state of the AuthBloc

// Check if the current state is an AuthState with an error

// Continue with the rest of your code...

class _EmailFormField extends StatelessWidget {
  const _EmailFormField({
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: emailController,
      hintText: StringConstants.emailHint,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) =>
          ValidateOperations.emailValidation(value) ??
          ValidateOperations.normalValidation(value),
    );
  }
}

class _UsernameFormField extends StatelessWidget {
  const _UsernameFormField({
    required this.usernameController,
  });

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: usernameController,
      hintText: StringConstants.usernameHint,
      onSaved: (value) {
        usernameController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _PasswordFormField extends StatefulWidget {
  const _PasswordFormField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<_PasswordFormField> {
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: widget.passwordController,
      hintText: StringConstants.passwordHint,
      isPassword: !isPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          isPasswordVisible
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          color: Colors.grey,
        ),
        onPressed: () {
          togglePasswordVisibility();
        },
      ),
      onSaved: (value) {
        widget.passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _RegisterButton extends StatefulWidget {
  const _RegisterButton({required this.onTap, required this.isDisabled});

  final VoidCallback onTap;
  final bool isDisabled;

  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<_RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: StringConstants.registerButtonText,
      onTap: widget.onTap,
      isDisabled: widget.isDisabled,
    );
  }
}
