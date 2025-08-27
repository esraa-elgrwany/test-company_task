part of 'theme_cubit.dart';

abstract class ThemeState {
  final ThemeData themeData;
  const ThemeState(this.themeData);
}

class ThemeInitial extends ThemeState {
  ThemeInitial(ThemeData themeData) : super(themeData);
}

