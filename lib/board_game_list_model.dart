import 'package:gsheets/gsheets.dart';
import 'board_game_list_view_model.dart';
import 'google_credentials.dart';

class BoardGameListModel {
  List<BoardGame> boardGames = [];

  Future<void> fetchBoardGameList() async {
    final gsheets = GSheets(credentials);
    final ss = await gsheets.spreadsheet(spreadsheetId);
    final sheet = ss.worksheetByTitle('BoardGameData');

    final data = await sheet?.values.allRows(fromRow: 2);

    for (var game in data!) {
      boardGames.add(
        BoardGame(
          title: game[0],
          minPlayerCount: int.parse(game[1]),
          maxPlayerCount: int.parse(game[2]),
          estimatedPlayTimeMinutes: int.parse(game[3]),
          extras: game[4].split('\n'),
          owned: bool.parse(game[5]),
        ),
      );
    }

    boardGames = boardGames.where((game) => game.owned == true).toList();
  }
}
