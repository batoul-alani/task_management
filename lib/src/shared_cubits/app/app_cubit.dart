import 'package:bloc/bloc.dart';
import 'package:maids_tasks_manager/src/injection_container.dart';
import 'package:maids_tasks_manager/src/utils/keys.dart';

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._sharedPreferences) : super(Unauthenticated()) {
    _initial();
  }

  final SharedPreferences _sharedPreferences;

  void _initial() {
    final bool isContainToken = _sharedPreferences.containsKey(Keys.token);
    if (isContainToken) {
      final String? token = _sharedPreferences.getString(Keys.token);
      emit(Authenticated(token!));
    }
  }

  Future<void> setAuthenticated(String token) async {
    await _sharedPreferences.setString(Keys.token, token);
    emit(Authenticated(token));
    resetApp();
  }

  Future<void> setUnauthenticated() async {
    await _sharedPreferences.remove(Keys.token);
    emit(Unauthenticated());
    resetApp();
  }
}
