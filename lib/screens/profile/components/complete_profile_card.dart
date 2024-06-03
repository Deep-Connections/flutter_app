import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileCard extends StatelessWidget {
  const CompleteProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return StreamBuilder(
        stream: getIt<UserStatusService>().userStatusStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final ProfileNavigationStep? step =
              snapshot.data?.additionalUncompletedStep;
          if (step != null) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: standardPadding),
                child: Card(
                  child: DcColumn(
                    children: [
                      Text(
                        loc.completeProfile_completeDescription,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.go(ProfileRoutes.complete
                                .parameterPath([step.navigationPath]));
                          },
                          child: Text(loc.completeProfile_completeButton)),
                    ],
                  ),
                ));
          }
          return const SizedBox(height: standardPadding);
        });
  }
}
