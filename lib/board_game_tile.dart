import 'package:flutter/material.dart';

import 'board_game_list_view_model.dart';

class BoardGameTile extends StatelessWidget {
  const BoardGameTile({super.key, required this.boardGame});

  final BoardGame boardGame;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(2),
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
                boardGame.title,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                "${boardGame.minPlayerCount} - ${boardGame.maxPlayerCount} players | ${boardGame.estimatedPlayTimeMinutes} minutes",
                style: TextStyle(
                  color: const Color.fromARGB(255, 73, 73, 73),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
