import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/chats/chat/chat.dart';
import 'package:deep_connections/models/chats/reviews/review.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/dialogs/confirmation_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class MatchReviewDialog extends StatefulWidget {
  final Profile profileToReview;
  final Chat chat;
  final Function(String chatId, {Review? review}) onUnmatch;

  const MatchReviewDialog({
    super.key,
    required this.profileToReview,
    required this.chat,
    required this.onUnmatch,
  });

  @override
  State<MatchReviewDialog> createState() => _MatchReviewDialogState();
}

class _MatchReviewDialogState extends State<MatchReviewDialog> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final firstName = widget.profileToReview.firstName ?? "";
    return AlertDialog(
        title: Text(loc.chat_unmatchDialogTitle(firstName)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(loc.chat_unmatchDialogHeadline(firstName),
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: standardPadding),
            Text(loc.chat_unmatchDialogHowGood,
                style: Theme.of(context).textTheme.bodyMedium),
            RatingStars(
              axis: Axis.horizontal,
              starSize: 25,
              value: _rating,
              onValueChanged: (rating) => setState(() => _rating = rating),
              valueLabelVisibility: false,
              starColor: Theme.of(context).colorScheme.primary,
              starOffColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            Flexible(
              child: TextField(
                minLines: 1,
                maxLines: null,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: loc.chat_unmatchDialogTextReviewPlaceholder,
                ),
              ),
            ),
          ],
        ),
        actions: getConfirmationButtons(
            context: context,
            onConfirm: _rating == 0
                ? null
                : () => widget.onUnmatch(widget.chat.id!,
                    review: Review(
                        text: _controller.text,
                        rating: _rating.toInt(),
                        chatId: widget.chat.id!,
                        reviewerId: widget.chat.currentUserId!,
                        connectedToId: widget.profileToReview.id!)),
            confirmText: loc.chat_unmatchDialogButton));
  }
}
