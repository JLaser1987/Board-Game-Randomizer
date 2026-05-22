import 'dart:math';

import 'package:board_game_randomizer/board_game_list_model.dart';
import 'package:flutter/material.dart';

class BoardGame {
  BoardGame({
    required this.title,
    required this.minPlayerCount,
    required this.maxPlayerCount,
    required this.estimatedPlayTimeMinutes,
    required this.extras,
    required this.owned,
  });

  final String title;
  final int minPlayerCount;
  final int maxPlayerCount;
  final int estimatedPlayTimeMinutes;
  final List<String> extras;
  final bool owned;
}

class BoardGameListViewModel extends ChangeNotifier {
  final BoardGameListModel model;
  List<BoardGame> filteredBoardGames = [];

  BoardGameListViewModel(this.model) {
    fetchBoardGames();
  }

  Future<void> fetchBoardGames() async {
    if (model.boardGames.isEmpty) {
      await model.fetchBoardGameList();
    }
    filteredBoardGames = model.boardGames;
    notifyListeners();
  }

  Future<void> filterBoardGames(int? playerCount, int? playTime) async {
    // Make sure we have the list of board games
    if (model.boardGames.isEmpty) {
      await model.fetchBoardGameList();
    }
    // Start with empty filter
    filteredBoardGames = model.boardGames;

    // Apply player count filter if set
    if (playerCount != null) {
      filteredBoardGames = filteredBoardGames
          .where(
            (game) =>
                game.minPlayerCount <= playerCount &&
                game.maxPlayerCount >= playerCount,
          )
          .toList();
    }

    // Apply play time filter if set
    if (playTime != null) {
      filteredBoardGames = filteredBoardGames
          .where((game) => game.estimatedPlayTimeMinutes <= playTime)
          .toList();
    }

    notifyListeners();
  }

  Future<BoardGame?> getRandomGameWithFilter(
    int? playerCount,
    int? playTime,
  ) async {
    // Make sure we have the list of board games
    if (model.boardGames.isEmpty) {
      await model.fetchBoardGameList();
    }
    // Start with empty filter
    List<BoardGame> possibleGames = model.boardGames;

    // Apply player count filter if set
    if (playerCount != null) {
      possibleGames = possibleGames
          .where(
            (game) =>
                game.minPlayerCount <= playerCount &&
                game.maxPlayerCount >= playerCount,
          )
          .toList();
    }

    // Apply play time filter if set
    if (playTime != null) {
      possibleGames = possibleGames
          .where((game) => game.estimatedPlayTimeMinutes <= playTime)
          .toList();
    }

    if (possibleGames.length == 0) {
      return null;
    }

    var randomIndex = Random().nextInt(possibleGames.length);
    return possibleGames[randomIndex];
  }
}
