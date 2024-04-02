import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dc_column.dart';
import '../components/form/field_input/field_input.dart';
import '../components/form/form_button.dart';

class ProfileBaseScreen extends StatefulWidget {
  final String title;
  final List<FieldInput> fields;
  final List<Widget> children;
  final Future<void> Function() onNext;
  final String? nextButtonText;

  const ProfileBaseScreen({
    super.key,
    required this.title,
    this.fields = const [],
    required this.onNext,
    this.nextButtonText,
    required this.children,
  });

  @override
  State<ProfileBaseScreen> createState() => _ProfileBaseScreenState();
}

class _ProfileBaseScreenState extends State<ProfileBaseScreen> {
  late final buttonInput = ButtonInput(fields: widget.fields);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return ProfileNoNextBaseScreen(
      title: widget.title,
      formKey: buttonInput.formKey,
      bottom: FormButton(
        text: widget.nextButtonText ?? loc.general_next,
        buttonInput: buttonInput,
        actionIfValid: widget.onNext,
      ),
      children: widget.children,
    );
  }
}

class ProfileNoNextBaseScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? bottom;
  final GlobalKey<FormState>? formKey;

  const ProfileNoNextBaseScreen(
      {super.key,
      required this.title,
      this.bottom,
      required this.children,
      this.formKey});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          Text(title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          Expanded(
            child: Form(
              key: formKey,
              child: DcColumn(
                children: [
                  Expanded(
                      child: ListView(
                    children: [...children],
                  )),
                  if (bottom != null) bottom!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
