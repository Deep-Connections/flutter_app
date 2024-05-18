import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/question/choice.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

final List<Question> freeTimeQuestionList = [
  SliderQuestion(
    id: 'indoor_outdoor',
    questionText: LocKey((loc) => loc.questionFreeTime_indoorOutdoor_question),
    minText: LocKey((loc) => loc.questionFreeTime_indoorOutdoor_answerMin),
    maxText: LocKey((loc) => loc.questionFreeTime_indoorOutdoor_answerMax),
    navigationPath: 'indoor_outdoor',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'spend_free_time',
    questionText: LocKey((loc) => loc.questionFreeTime_spendFreeTime_question),
    choices: [
      Choice('active',
          LocKey((loc) => loc.questionFreeTime_spendFreeTime_answer_active)),
      Choice('relax',
          LocKey((loc) => loc.questionFreeTime_spendFreeTime_answer_relax)),
      Choice('goingOut',
          LocKey((loc) => loc.questionFreeTime_spendFreeTime_answer_goingOut)),
      Choice(
          'friendsFamily',
          LocKey((loc) =>
              loc.questionFreeTime_spendFreeTime_answer_friendsFamily)),
      Choice('hobby',
          LocKey((loc) => loc.questionFreeTime_spendFreeTime_answer_hobby))
    ],
    maxChoices: 3,
    navigationPath: 'spend_free_time',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'do_with_friends',
    questionText: LocKey((loc) => loc.questionFreeTime_doWithFriends_question),
    choices: [
      Choice('active',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_active)),
      Choice('nature',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_nature)),
      Choice('musical',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_musical)),
      Choice('cultural',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_cultural)),
      Choice('creative',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_creative)),
      Choice('games',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_games)),
      Choice(
          'entertainment',
          LocKey((loc) =>
              loc.questionFreeTime_doWithFriends_answer_entertainment)),
      Choice('party',
          LocKey((loc) => loc.questionFreeTime_doWithFriends_answer_party))
    ],
    maxChoices: 4,
    navigationPath: 'do_with_friends',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'new_activities',
    questionText: LocKey((loc) => loc.questionFreeTime_newActivities_question),
    choices: [
      Choice('always',
          LocKey((loc) => loc.questionFreeTime_newActivities_answer_always)),
      Choice('open',
          LocKey((loc) => loc.questionFreeTime_newActivities_answer_open)),
      Choice('stick',
          LocKey((loc) => loc.questionFreeTime_newActivities_answer_stick)),
    ],
    navigationPath: 'new_activities',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'see_partner',
    questionText: LocKey((loc) => loc.questionFreeTime_seePartner_question),
    choices: [
      Choice('daily',
          LocKey((loc) => loc.questionFreeTime_seePartner_answer_daily)),
      Choice('three',
          LocKey((loc) => loc.questionFreeTime_seePartner_answer_three)),
      Choice(
          'two', LocKey((loc) => loc.questionFreeTime_seePartner_answer_two)),
      Choice('rarely',
          LocKey((loc) => loc.questionFreeTime_seePartner_answer_rarely))
    ],
    navigationPath: 'see_partner',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'vacation',
    questionText: LocKey((loc) => loc.questionFreeTime_vacation_question),
    choices: [
      Choice('cities',
          LocKey((loc) => loc.questionFreeTime_vacation_answer_cities)),
      Choice('relaxing',
          LocKey((loc) => loc.questionFreeTime_vacation_answer_relaxing)),
      Choice('visiting',
          LocKey((loc) => loc.questionFreeTime_vacation_answer_visiting)),
      Choice('nature',
          LocKey((loc) => loc.questionFreeTime_vacation_answer_nature)),
      Choice('hobbies',
          LocKey((loc) => loc.questionFreeTime_vacation_answer_hobbies)),
    ],
    maxChoices: 3,
    navigationPath: 'vacation',
    section: ProfileSection.freeTime,
  ),
  SliderQuestion(
    id: 'planning',
    questionText: LocKey((loc) => loc.questionFreeTime_planning_question),
    minText: LocKey((loc) => loc.questionFreeTime_planning_answerMin),
    maxText: LocKey((loc) => loc.questionFreeTime_planning_answerMax),
    navigationPath: 'planning',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'conversation_topics',
    questionText:
        LocKey((loc) => loc.questionFreeTime_conversationTopics_question),
    choices: [
      Choice(
          'science',
          LocKey(
              (loc) => loc.questionFreeTime_conversationTopics_answer_science)),
      Choice(
          'worldAffairs',
          LocKey((loc) =>
              loc.questionFreeTime_conversationTopics_answer_worldAffairs)),
      Choice(
          'psychology',
          LocKey((loc) =>
              loc.questionFreeTime_conversationTopics_answer_psychology)),
      Choice(
          'meaningOfLife',
          LocKey((loc) =>
              loc.questionFreeTime_conversationTopics_answer_meaningOfLife)),
      Choice(
          'holiday',
          LocKey(
              (loc) => loc.questionFreeTime_conversationTopics_answer_holiday)),
      Choice(
          'entertainment',
          LocKey((loc) =>
              loc.questionFreeTime_conversationTopics_answer_entertainment)),
      Choice(
          'games',
          LocKey(
              (loc) => loc.questionFreeTime_conversationTopics_answer_games)),
      Choice(
          'beauty',
          LocKey(
              (loc) => loc.questionFreeTime_conversationTopics_answer_beauty)),
      Choice(
          'health',
          LocKey(
              (loc) => loc.questionFreeTime_conversationTopics_answer_health))
    ],
    maxChoices: 4,
    navigationPath: 'conversation_topics',
    section: ProfileSection.freeTime,
  ),
  MultipleChoiceQuestion(
    id: 'social_media',
    questionText: LocKey((loc) => loc.questionFreeTime_socialMedia_question),
    choices: [
      Choice('messaging',
          LocKey((loc) => loc.questionFreeTime_socialMedia_answer_messaging)),
      Choice('scroll',
          LocKey((loc) => loc.questionFreeTime_socialMedia_answer_scroll)),
      Choice('create',
          LocKey((loc) => loc.questionFreeTime_socialMedia_answer_create)),
    ],
    maxChoices: 2,
    navigationPath: 'social_media',
    section: ProfileSection.freeTime,
  ),
];
