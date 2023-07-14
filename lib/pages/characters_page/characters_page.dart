import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/service/character_client.dart';
import 'package:rick_and_morty/data/service/episode_client.dart';
import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/model/episode.dart';
import 'package:rick_and_morty/util/pagination_builder.dart';
import 'package:rick_and_morty/util/path_id.dart';

import 'widgets/character_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({
    super.key,
    required this.characterClient,
    required this.episodeClient,
  });

  final CharacterClient characterClient;
  final EpisodeClient episodeClient;

  Future<(List<Character>, bool)> _loadCharacters(int page) async {
    try {
      final pagination = await characterClient.getCharacters(
        page: page,
      );
      final episodesMap = await _loadEpisodes(pagination.results) ?? {};

      var charactersWithEpisode = pagination.results
          .map(
            (ch) => ch.copyWith(
              firstEpisodeName: episodesMap[ch.episode.firstOrNull ?? '']?.name,
            ),
          )
          .toList();

      return (charactersWithEpisode, pagination.info.next != null);
    } catch (e) {
      debugPrint(e.toString());
    }
    return (<Character>[], false);
  }

  Future<Map<String, Episode>?> _loadEpisodes(
    List<Character> characters,
  ) async {
    final ids = characters
        .map((ch) => ch.episode.firstOrNull)
        .whereType<String>()
        .map((e) => e.id)
        .join(',');

    try {
      final episodes = await episodeClient.getMultipleEpisode(ids);
      return episodes.asMap().map((_, ep) => MapEntry(ep.url, ep));
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaginationBuilder<Character>(
          paginationCallback: _loadCharacters,
          builder: (context, controller, snapshot) {
            final characters = snapshot.data;

            if (characters == null) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            return ListView.separated(
              controller: controller,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              itemBuilder: (context, index) {
                final character = characters[index];
                return CharacterCard(
                  character: character,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 20,
              ),
              itemCount: characters.length,
            );
          },
        ),
      ),
    );
  }
}