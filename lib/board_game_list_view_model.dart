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
}
