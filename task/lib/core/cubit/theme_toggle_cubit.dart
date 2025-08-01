import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
 import 'package:task/config/theme/app_theme_data.dart';

 
enum AppThemeMode { light, dark }

class ThemeState {
  final AppThemeMode themeMode;

  const ThemeState({
    required this.themeMode,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

 
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(
    themeMode: AppThemeMode.light,
  ));

  void toggleTheme(BuildContext context) {
    if (state.themeMode == AppThemeMode.light) {
      emit(const ThemeState(themeMode: AppThemeMode.dark));
    } else {
      emit(const ThemeState(themeMode: AppThemeMode.light));
    }
  }

  void setLightTheme() {
    emit(const ThemeState(themeMode: AppThemeMode.light));
  }

  void setDarkTheme() {
    emit(const ThemeState(themeMode: AppThemeMode.dark));
  }

  ThemeData getThemeData(BuildContext context) {
    return state.themeMode == AppThemeMode.light
        ? AppThemeData.lightTheme(context)
        : AppThemeData.darkTheme(context);
  }

  bool get isDarkMode => state.themeMode == AppThemeMode.dark;
}