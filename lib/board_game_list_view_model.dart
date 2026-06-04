import 'dart:math';

import 'package:board_game_randomizer/board_game_list_model.dart';
import 'package:flutter/material.dart';

class BoardGame {
  BoardGame({
    this.row = -1,
    required this.title,
    required this.minPlayerCount,
    required this.maxPlayerCount,
    required this.estimatedPlayTimeMinutes,
    required this.extras,
    required this.owned,
  });

  int row;
  final String title;
  final int minPlayerCount;
  final int maxPlayerCount;
  final int estimatedPlayTimeMinutes;
  final String extras;
  final bool owned;
}

class BoardGameListViewModel extends ChangeNotifier {
  final BoardGameListModel model;
  List<BoardGame> filteredBoardGames = [];

  int? _currentPlayerCountFilter;
  int? _currentPlayTimeFilter;

  BoardGameListViewModel(this.model) {
    fetchBoardGames();
  }

  Future<void> fetchBoardGames() async {
    await model.fetchBoardGameList();
    filteredBoardGames = model.boardGames;
    filterBoardGames(_currentPlayerCountFilter, _currentPlayTimeFilter);
    notifyListeners();
  }

  Future<bool> saveBoardGame(BoardGame game) async {
    bool result;
    if (game.row >= 2) {
      result = await model.updateBoardGame(game.row, game);
    } else {
      result = await model.addBoardGame(game);
    }

    await fetchBoardGames();

    // Update the list with the changes and reapply any filters that existed
    filterBoardGames(_currentPlayerCountFilter, _currentPlayTimeFilter);

    return result;
  }

  Future<bool> removeBoardGame(BoardGame game) async {
    return await model.removeBoardGame(game.title);
  }

  Future<void> filterBoardGames(int? playerCount, int? playTime) async {
    // Make sure we have the list of board games
    if (model.boardGames.isEmpty) {
      await model.fetchBoardGameList();
    }
    // Start with empty filter
    filteredBoardGames = model.boardGames;

    // Save filter options so it can be reapplied when needed
    _currentPlayerCountFilter = playerCount;
    _currentPlayTimeFilter = playTime;

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

    if (possibleGames.isEmpty) {
      return null;
    }

    var randomIndex = Random().nextInt(possibleGames.length);
    return possibleGames[randomIndex];
  }
}
