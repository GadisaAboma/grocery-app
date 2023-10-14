import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/repository/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import "dart:developer" as developer;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthDataLoading()) {
    on<AuthLogin>((event, emit) async {
     
      try {
        emit(AuthSigningIn());
      await authRepository.loginUser(event.user);
        emit(AuthLoginSuccess());
      } catch (e) {
        emit(AuthOperationFailure(reason: e.toString()));
      }
    });
  }

 
}
