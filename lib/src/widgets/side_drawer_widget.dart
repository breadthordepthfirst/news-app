import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final Function tapAction;

  SideDrawer({
    @required this.tapAction,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Pick a news stream',
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.clear,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.line_style,
              size: 20,
            ),
            title: Text(
              'Top Headlines',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
            onTap: () => tapAction('Top Headlines'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.language,
              size: 20,
            ),
            title: Text(
              'News',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
            onTap: () => tapAction('News'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
