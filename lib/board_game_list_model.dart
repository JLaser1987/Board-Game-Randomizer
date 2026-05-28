import 'package:gsheets/gsheets.dart';
import 'board_game_list_view_model.dart';
import 'google_credentials.dart';

class BoardGameListModel {
  BoardGameListModel() {
    create();
  }

  Future<void> create() async {
    final gsheets = GSheets(credentials);
    final ss = await gsheets.spreadsheet(spreadsheetId);
    sheet = ss.worksheetByTitle('BoardGameData');
  }

  Worksheet? sheet;

  List<BoardGame> boardGames = [];

  Future<void> fetchBoardGameList() async {
    if (sheet == null) {
      await create();
    }
    final data = await sheet?.values.allRows(fromRow: 2);

    boardGames = [];

    for (var (index, game) in data!.indexed) {
      boardGames.add(
        BoardGame(
          row: index + 2,
          title: game[0],
          minPlayerCount: int.parse(game[1]),
          maxPlayerCount: int.parse(game[2]),
          estimatedPlayTimeMinutes: int.parse(game[3]),
          extras: game[4],
          owned: bool.parse(game[5]),
        ),
      );
    }

    boardGames.sort((a, b) {
      int nameComp = a.title.toLowerCase().compareTo(b.title.toLowerCase());
      return nameComp;
    });
    // Filter out board games that are no longer owned
    boardGames = boardGames.where((game) => game.owned == true).toList();
  }

  Future<void> updateBoardGame(int row, BoardGame updated) async {
    if (sheet == null) {
      await create();
    }

    bool? success = await sheet?.values.insertRow(row, [
      updated.title,
      updated.minPlayerCount,
      updated.maxPlayerCount,
      updated.estimatedPlayTimeMinutes,
      updated.extras,
    ]);

    if (success == null || !success) {
      // report error
    } else {
      fetchBoardGameList();
    }
  }

  Future<void> addBoardGame(BoardGame newGame) async {
    if (sheet == null) {
      await create();
    }

    bool? success = await sheet?.values.appendRow([
      newGame.title,
      newGame.minPlayerCount,
      newGame.maxPlayerCount,
      newGame.estimatedPlayTimeMinutes,
      newGame.extras,
      newGame.owned,
    ]);

    if (success == null || !success) {
      // report error
    } else {
      fetchBoardGameList();
    }
  }

  Future<void> removeBoardGame(String gameTitle) async {
    if (sheet == null) {
      await create();
    }

    bool? success = await sheet?.values.insertValueByKeys(
      false,
      columnKey: 'Still Owned',
      rowKey: gameTitle,
    );

    if (success == null || !success) {
      // report error
    } else {
      fetchBoardGameList();
    }
  }
}
