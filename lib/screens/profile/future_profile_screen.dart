import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/form/button_input.dart';
import 'package:deep_connections/screens/components/form/field_input/field_input.dart';
import 'package:deep_connections/screens/components/form/form_button.dart';
import 'package:deep_connections/screens/components/future_builder.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BaseProfileScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottom;
  final GlobalKey<FormState>? formKey;

  const BaseProfileScreen(
      {super.key,
      required this.title,
      required this.child,
      this.bottom,
      this.formKey});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        body: DcColumn(
      children: [
        Text(title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        Form(
          key: formKey,
          child: Expanded(
            child: child,
          ),
        ),
        if (bottom != null) bottom!,
      ],
    ));
  }
}

class FutureFieldProfileScreen extends StatefulWidget {
  final String title;
  final List<FieldInput> fields;
  final ProfileService profileService;
  final Future<void> Function() onNext;
  final String? nextButtonText;
  final Widget Function(BuildContext context, Profile profile) builder;

  const FutureFieldProfileScreen(
      {super.key,
      required this.profileService,
      required this.title,
      required this.builder,
      required this.onNext,
      this.nextButtonText,
      this.fields = const []});

  @override
  State<FutureFieldProfileScreen> createState() =>
      _FutureFieldProfileScreenState();
}

class _FutureFieldProfileScreenState extends State<FutureFieldProfileScreen> {
  late final buttonInput = ButtonInput(fields: widget.fields);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseProfileScreen(
      formKey: buttonInput.formKey,
      title: widget.title,
      bottom: FormButton(
        text: widget.nextButtonText ?? loc.general_next,
        buttonInput: buttonInput,
        actionIfValid: widget.onNext,
      ),
      child: GenericFutureBuilder(
        data: widget.profileService.profile,
        builder: widget.builder,
      ),
    );
  }
}
