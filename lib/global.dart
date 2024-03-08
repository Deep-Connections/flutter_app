import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';

class Global {
  static AppLocalizations get loc {
    final context = navigatorKey.currentContext;
    return AppLocalizations.of(context!);
  }
}
