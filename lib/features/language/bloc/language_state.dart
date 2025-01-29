part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState({this.locale});
  final Locale? locale;
  @override
  List<Object> get props => [locale ?? ""];
}

class LanguageInitialState extends LanguageState {
  LanguageInitialState() : super(locale: null);
}

class LanguageChangedState extends LanguageState {
  LanguageChangedState({required super.locale});
}
