import 'package:flutter/material.dart';

class LandingPageCardTileModel {
  final String title;
  final String buttonText;
  final Function onbuttonPressed;
  final IconData icon;
  LandingPageCardTileModel(
      {@required this.title, this.icon, this.buttonText, this.onbuttonPressed});
}

class LandingPageCard extends StatelessWidget {
  final List<LandingPageCardTileModel> tiles;

  LandingPageCard({@required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: tiles
            .asMap()
            .map((i, tile) => MapEntry(
                i,
                Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(tile.icon),
                      title: Text(tile.title),
                      trailing: FlatButton(
                        child: Text(tile.buttonText),
                        onPressed: tile.onbuttonPressed,
                      ),
                    ),
                    i != (tiles.length - 1) ? Divider() : SizedBox.shrink(),
                  ],
                )))
            .values
            .toList(),
      ),
    );
  }
}
