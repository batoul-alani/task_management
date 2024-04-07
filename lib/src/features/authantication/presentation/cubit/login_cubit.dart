import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';
import 'package:maids_tasks_manager/src/features/authantication/data/auth_repository.dart';
import 'package:maids_tasks_manager/src/injection_container.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final data = await getIt<AuthRepository>().login(email, password);
      await getIt<AppCubit>().setAuthenticated(data.token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
