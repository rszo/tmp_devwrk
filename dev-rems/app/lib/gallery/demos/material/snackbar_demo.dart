// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// BEGIN snackbarsDemo

class SnackbarsDemo extends StatelessWidget {
  const SnackbarsDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).demoSnackbarsTitle),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context).demoSnackbarsText),
              action: SnackBarAction(
                label: AppLocalizations.of(context)
                    .demoSnackbarsActionButtonLabel,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    AppLocalizations.of(context).demoSnackbarsAction,
                  )));
                },
              ),
            ));
          },
          child:
              Text(AppLocalizations.of(context).demoSnackbarsButtonLabel),
        ),
      ),
    );
  }
}

// END
