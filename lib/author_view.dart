import 'package:flutter/material.dart';

import 'Utility/dimens.dart';
import 'Utility/strings.dart';

class AuthorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.authorInfo),
      ),
      body: Container(
        margin: EdgeInsets.all(Dimens.standardDistance),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: Dimens.standardDistance),
              alignment: Alignment.center,
              child: Text(
                Strings.authorAuthor,
                style: TextStyle(fontSize: Dimens.fontSecodnary),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(Dimens.smallDistance),
              alignment: Alignment.center,
              child: Text(
                Strings.authorName,
                style: TextStyle(
                  fontSize: Dimens.fontPrimary,
                  color: Colors.blue,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: Dimens.standardDistance),
              alignment: Alignment.center,
              child: Text(
                Strings.authorStudentID,
                style: TextStyle(fontSize: Dimens.fontSecodnary),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
              child: Text(Strings.back),
            )
          ],
        ),
      ),
    );
  }
}
