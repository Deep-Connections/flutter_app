import 'package:deep_connections/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DcDatePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final DateTime? minDateTime;
  final DateTime? maxDateTime;
  final double datePickerHeight;

  const DcDatePicker(
      {super.key,
      this.initialDateTime,
      this.minDateTime,
      this.maxDateTime,
      this.datePickerHeight = 220});

  @override
  State<DcDatePicker> createState() => _DcDatePickerState();
}

class _DcDatePickerState extends State<DcDatePicker> {
  late DateTime? selectedDate = widget.initialDateTime;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: standardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.datePickerHeight,
            child: ScrollConfiguration(
              behavior: DatePickerScrollBehavior(),
              child: CupertinoDatePicker(
                initialDateTime: widget.initialDateTime,
                mode: CupertinoDatePickerMode.date,
                minimumDate: widget.minDateTime,
                maximumDate: widget.maxDateTime,
                onDateTimeChanged: (date) => selectedDate = date,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(selectedDate),
              child: Text(loc.general_select))
        ],
      ),
    );
  }
}

class DatePickerScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
