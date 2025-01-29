import 'package:asd_test/core/l10n/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitialState()) {
    on<LanguageEvent>((event, emit) {
      if (!L10n.all.contains(event.locale)) return;
      emit(LanguageChangedState(locale: event.locale));
    });
  }
}
