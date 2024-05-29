import 'dart:async';

import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const maxMatches = 5;

class CreateMatchSection extends StatefulWidget {
  final Profile profile;
  final Future Function() createMatch;

  const CreateMatchSection(
      {super.key, required this.profile, required this.createMatch});

  @override
  State<CreateMatchSection> createState() => _CreateMatchSectionState();
}

class _CreateMatchSectionState extends State<CreateMatchSection> {
  Timer? _timer;
  bool _isCreatingMatch = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_getDurationUntilNextMatch() != null) {
        setState(() {});
      }
    });
  }

  Duration? _getDurationUntilNextMatch() {
    final now = DateTime.now();
    final lastMatchedAt = widget.profile.lastMatchedAt;
    if (lastMatchedAt == null) return null;
    final difference =
        lastMatchedAt.add(durationUntilNextMatch).difference(now);
    return difference.isNegative ? null : difference;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _durationToString(Duration duration, AppLocalizations loc) {
    if (duration.inHours == 0) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    return loc.matching_matchAgainHoursHeadline(duration.inHours.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = _getDurationUntilNextMatch();
    final reachedMaxMatches = widget.profile.numMatches == maxMatches;
    final needsToWaitForMatch = duration != null;
    final canCreateMatch = !reachedMaxMatches && !needsToWaitForMatch;
    final loc = AppLocalizations.of(context);
    return DcColumn(children: [
      const SizedBox(height: standardPadding),
      Text(
        needsToWaitForMatch
            ? loc.matching_matchAgainHoursDescription
            : reachedMaxMatches
                ? loc.matching_tooManyMatchesDescription(maxMatches)
                : loc.matching_readyToMatchDescription,
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineSmall,
      ),
      Text(
        needsToWaitForMatch
            ? _durationToString(duration, loc)
            : reachedMaxMatches
                ? loc.matching_tooManyMatchesHeadline
                : loc.matching_readyToMatchHeadline,
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineMedium,
      ),
      ElevatedButton(
        onPressed: canCreateMatch
            ? () async {
                if (_isCreatingMatch) return;
                setState(() => _isCreatingMatch = true);
                await widget.createMatch();
                setState(() => _isCreatingMatch = false);
              }
            : null,
        child: _isCreatingMatch
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : Text(
                loc.matching_createMatchButton,
              ),
      )
    ]);
  }
}
