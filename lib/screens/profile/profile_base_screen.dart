import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/dc_column.dart';
import '../components/form/field_input.dart';
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
    required this.fields,
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
    return BaseScreen(
        title: widget.title,
        body: Form(
          key: buttonInput.formKey,
          child: DcColumn(
            children: [
              Expanded(
                  child: ListView(
                children: widget.children,
              )),
              FormButton(
                text: widget.nextButtonText ?? loc.general_next,
                buttonInput: buttonInput,
                actionIfValid: widget.onNext,
              ),
            ],
          ),
        ));
  }
}
