import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:registration_screen/injection.dart';
import 'package:registration_screen/presentation/core/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureInjection(Environment.dev);
  runApp(AppWidget());
}
