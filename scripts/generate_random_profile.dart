import 'dart:io';
import 'dart:math';

import 'package:deep_connections/config/question_list.dart';
import 'package:deep_connections/models/gender.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/language_helper.dart';
import 'package:flutter_test/flutter_test.dart';

//flutter test scripts/generate_random_profile.dart

final random = Random();

void main() {
  Map<String, dynamic> generateRandomProfile() {
    final genderInt = random.nextInt(2);
    final randomGender = Gender.base[genderInt];
    final genderLookingFor = Gender.base[1 - genderInt];

    final languageCountryCodes = (firstLanguageCodes.take(10).toList()
          ..shuffle(random))
        .take(random.nextInt(4) + 2)
        .toList();

    final languageCodes = languageCountryCodes
        .map((code) => code.split('_').first)
        .toSet()
        .toList();
    var profile = Profile(
      firstName: 'John',
      gender: randomGender.enumValue,
      genderPreferences: [genderLookingFor.enumValue],
      languageCodes: languageCodes,
      languageWithCountryCodes: languageCountryCodes,
    );

    final Map<String, Answer> questions = Map.from(profile.questions ?? {});

    for (final question in allQuestionsList) {
      if (question is MultipleChoiceQuestion) {
        final randomAnswerPermutation = question.choices
            .map((choice) => choice.id)
            .toList()
          ..shuffle(random);
        questions[question.id] = Answer(
          choices: randomAnswerPermutation.sublist(0, question.maxChoices),
        );
      }

      if (question is SliderQuestion) {
        final step = 1 / (question.divisions - 1);
        var sliderValue = step * random.nextInt(question.divisions);
        sliderValue = double.parse(sliderValue.toStringAsFixed(10));
        questions[question.id] = Answer(confidence: sliderValue);
      }
    }

    final randomDate =
        DateTime(1980, 1, 1).add(Duration(days: random.nextInt(365 * 20)));
    final json = profile.copyWith(questions: questions).toJson();
    json['dateOfBirth'] = randomDate.toIso8601String();
    return json;
  }

  /*test('Generate random profile', () {
    File file = File('scripts/generated/single_profile.json');
    file.writeAsStringSync(jsonEncode(generateRandomProfile()));
    File fileMultiple = File('scripts/generated/multiple_profile.json');
    final profiles = List.generate(10, (_) => generateRandomProfile());
    fileMultiple.writeAsStringSync(
        jsonEncode(profiles));
  });*/

  String newLineList(List<String> list) {
    return "[\n  ${list.map((e) => '"$e"').join(',\n  ')},\n]";
  }

  test('Generate javascript constants', () {
    final genderValues = Gender.values.map((g) => g.enumValue).toList();

    final questionIds = allQuestionsList.map((q) => q.id).toList();

    final genderJS = """
const AllGenders = ${newLineList(genderValues)};

const GenderEveryone = \"${Gender.everyone.enumValue}\";

const AllQuestions = ${newLineList(questionIds)};

module.exports = { AllGenders, GenderEveryone, AllQuestions };
""";
    File file = File('functions/generated_flutter_constants.js');
    file.writeAsStringSync(genderJS);
  });
}
