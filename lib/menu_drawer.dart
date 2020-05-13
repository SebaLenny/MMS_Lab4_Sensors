import 'package:flutter/material.dart';

import 'Utility/strings.dart';
import 'author_view.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        ListTile(
          title: Text(Strings.authorInfo),
          trailing: Icon(Icons.person),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthorView(),
              ),
            );
          },
        ),
      ],
    ));
  }
}
