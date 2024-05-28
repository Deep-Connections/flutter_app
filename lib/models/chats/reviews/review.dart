

import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@Freezed(toJson: true)
class Review with _$Review {
  const Review._();

  const factory Review({
    required String text,
    required int rating,
    required String chatId,
    required String reviewerId,
    required String connectedToId,
  }) = _Review;

}
