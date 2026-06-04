import 'package:board_game_randomizer/add_edit_board_game.dart';
import 'package:flutter/material.dart';

import 'board_game_details_view.dart';
import 'board_game_list_view_model.dart';

class BoardGameTile extends StatefulWidget {
  BoardGameTile({super.key, required this.boardGame});

  BoardGame boardGame;

  @override
  State<BoardGameTile> createState() => _BoardGameTileState();
}

class _BoardGameTileState extends State<BoardGameTile> {
  Future<void> _getDetailsScreenNavigate(BuildContext context) async {
    // The result will capture whatever you passed to Navigator.pop
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BoardGameDetails(boardGame: widget.boardGame),
      ),
    );

    // Always verify the result isn't null (e.g., if the user swiped/hit the native back button)
    if (result != null) {
      setState(() {
        widget.boardGame = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(2),
      child: GestureDetector(
        onTap: () => _getDetailsScreenNavigate(context),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  widget.boardGame.title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "${widget.boardGame.minPlayerCount} - ${widget.boardGame.maxPlayerCount} players | ${widget.boardGame.estimatedPlayTimeMinutes} minutes",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 73, 73, 73),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
