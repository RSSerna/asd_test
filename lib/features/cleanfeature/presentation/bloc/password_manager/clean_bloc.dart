import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/clean_param.dart';
import '../../../domain/usecase/clean_noparams_usecase.dart';
import '../../../domain/usecase/clean_params_usecase.dart';

part 'clean_event.dart';
part 'clean_state.dart';

class CleanBloc extends Bloc<CleanEvent, CleanState> {
  final CleanNoParamsUseCase restorePassword;
  final CleanParamsUseCase changePassword;

  CleanBloc({
    required this.restorePassword,
    required this.changePassword,
  }) : super(const PasswordManagerInitialState()) {
    on<ChangePasswordEvent>((event, emit) async {
      emit(const PasswordManagerLoadingState());

      final failureOrAccepted = await changePassword(CleanParams(
          email: "tempEmail",
          password: event.oldPassword,
          newPassword: event.newPassword));

      failureOrAccepted.fold((error) {
        emit(PasswordManagerErrorState(
          errorStr: _mapFailureToMessage(error, "Password: "),
          email: state.email,
        ));
      }, (accepted) {
        emit(const PasswordManagerAcceptedState());
        emit(const PasswordManagerInitialState());
      });
    });

    on<RestorePasswordEvent>((event, emit) async {
      emit(const PasswordManagerLoadingState());

      final failureOrAccepted = await restorePassword(NoParams());

      failureOrAccepted.fold((error) {
        emit(PasswordManagerErrorState(
          errorStr: _mapFailureToMessage(error, "Password: "),
          email: state.email,
        ));
      }, (accepted) {
        emit(const PasswordManagerAcceptedState());
        emit(const PasswordManagerInitialState());
      });
    });
  }

  String _mapFailureToMessage(Failure failure, String from) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return from + Constants.serverFailureMessage;
      default:
        return '$from Unexpected Error';
    }
  }
}
