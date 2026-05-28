import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'board_game_list_view_model.dart';

class BoardGameDetails extends StatelessWidget {
  const BoardGameDetails({super.key, required this.boardGame});

  final BoardGame boardGame;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: Column(
          children: [
            Text(
              boardGame.title,
              textAlign: .center,
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
            Text(
              "Player Count:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: .bold,
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
            Row(
              mainAxisAlignment: .center,
              children: [
                Icon(Icons.people),
                Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0)),
                Text(
                  '${boardGame.minPlayerCount} - ${boardGame.maxPlayerCount} players',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
            Text(
              "Estimated Playtime:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: .bold,
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
            Row(
              mainAxisAlignment: .center,
              children: [
                FaIcon(FontAwesomeIcons.clock),
                Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 0, 5, 0)),
                Text(
                  '${boardGame.estimatedPlayTimeMinutes} minutes',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
            Text(
              "Additional Items:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: .bold,
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.fromLTRB(0, 10, 0, 0)),
            Text(
              boardGame.extras,
              textAlign: .center,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
