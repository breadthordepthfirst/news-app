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
            title: Text('Customize Granularity ? Pick one !'),
          ),
          ListTile(
            leading: Icon(
              Icons.view_headline,
            ),
            title: Text(
              'Top Headlines',
            ),
            onTap: () => tapAction('Top Headlines'), 
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.trending_up,
            ),
            title: Text('All News'),
            onTap: () => tapAction('All News'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
