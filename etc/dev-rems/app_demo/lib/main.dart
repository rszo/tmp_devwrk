import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  configureApp();

  // TODO: https://github.com/flutter/flutter/blob/2.5.0/packages/flutter_tools/templates/skeleton/lib/main.dart.tmpl
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
