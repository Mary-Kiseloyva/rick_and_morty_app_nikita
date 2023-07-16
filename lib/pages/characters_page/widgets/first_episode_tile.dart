import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/character.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstEpisodeTile extends StatelessWidget {
  const FirstEpisodeTile({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.firstSeenIn,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          character.firstEpisodeName ?? '',
        ),
      ],
    );
  }
}
