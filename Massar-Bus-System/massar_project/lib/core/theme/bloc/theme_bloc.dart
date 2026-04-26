import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<LoadTheme>(_onLoadTheme);
    on<ChangeTheme>(_onChangeTheme);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);
    
    if (themeIndex != null) {
      emit(ThemeState(themeMode: ThemeMode.values[themeIndex]));
    } else {
      emit(const ThemeState(themeMode: ThemeMode.system));
    }
  }

  Future<void> _onChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, event.themeMode.index);
    emit(ThemeState(themeMode: event.themeMode));
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final currentMode = state.themeMode;
    ThemeMode newMode;
    
    if (currentMode == ThemeMode.dark) {
      newMode = ThemeMode.light;
    } else if (currentMode == ThemeMode.light) {
      newMode = ThemeMode.dark;
    } else {
      // If system, toggle based on current brightness
      // Note: In a Bloc, we don't have access to context. 
      // We'll default to toggling from system to dark if it was light, or vice-versa.
      // A better way is to pass current brightness or just toggle to dark.
      newMode = ThemeMode.dark; 
    }
    
    add(ChangeTheme(newMode));
  }
}
