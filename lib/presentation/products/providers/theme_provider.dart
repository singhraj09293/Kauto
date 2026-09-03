import 'package:flutter/material.dart';
import 'package:riverpod/legacy.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
