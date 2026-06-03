import 'package:assignment_abybaby/core/utils/app_settings.dart';
import 'package:assignment_abybaby/data/repository/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../my_app.dart';
import '../../../route/app_routes.dart';
import '../auth_event/auth_event.dart';
import '../auth_state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoginLoading: true,
        isLoginSuccess: false,
        loginError: null,
      ),
    );

    try {
      final response =await authRepository.userLogin(
        email: event.email,
        password: event.password,
      );
      if(response.data!=null&& response.success){
        AppSettings.saveAccessToken(response.data!.accessToken);
        emit(
          state.copyWith(
            isLoginLoading: false,
            isLoginSuccess: true, /// TEST CASE, UI IMPROVEMENT
            loginError: null,
          ));
      }else{
        emit(
          state.copyWith(
            isLoginLoading: false,
            isLoginSuccess: false,
            loginError: response.message,
          ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoginLoading: false,
          isLoginSuccess: false,
          loginError:e.toString(),
        ),
      );
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        isRegisterLoading: true,
        isRegisterSuccess: false,
        registerError: null,
      ),
    );

    try {
      final response = await authRepository.userRegistration(
        name: event.name,
        email: event.email,
        password: event.password,
        gender: event.gender,
        phone: event.phone,
      );

      if (response.data != null&& response.success) {
        emit(
          state.copyWith(
            isRegisterLoading: false,
            isRegisterSuccess: true,
            registerError: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isRegisterLoading: false,
            isRegisterSuccess: false,
            registerError: response.message,
          ));
      }


    } catch (e) {
      if(e.toString().contains('Logout')){
        AppSettings.clearAccessToken();
        navigatorKey.currentContext?.go(AppRoute.login);
      }
      emit(
        state.copyWith(
          isRegisterLoading: false,
          isRegisterSuccess: false,
          registerError: e.toString(),
        ),
      );
    }
  }
}
