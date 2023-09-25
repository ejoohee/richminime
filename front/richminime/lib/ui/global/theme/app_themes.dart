import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppTheme {
  LightMode,
  DarkMode,
}

final appThemeData = {
  AppTheme.LightMode: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.DarkMode: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
  ),
};
