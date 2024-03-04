import 'package:deep_connections/screens/components/BaseScreen.dart';
import 'package:deep_connections/screens/components/DcColumn.dart';
import 'package:deep_connections/screens/components/form/DcTextFormField.dart';
import 'package:deep_connections/screens/components/form/FieldInput.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final email = EmailInput();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Reset Password",
      body: DcColumn(children: [
        const Text("Enter your email to reset your password"),
        DcTextFormField(fieldInput: email, key: _formKey),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() == true) {
              _auth.sendPasswordResetEmail(email: email.value);
            }
          },
          child: const Text("Reset Password"),
        )
      ]),
    );
  }
}
