class BoardGameListModel {
  List<String> boardGames = [];

  BoardGameListModel() {
    fetchBoardGameList();
  }

  void fetchBoardGameList() async {
    // TODO: Load list of games from google spreadsheet
    boardGames = ['a', 'b', 'c', 'd'];
  }
}
