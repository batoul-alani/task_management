import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids_tasks_manager/src/features/authantication/data/auth_repository.dart';
import 'package:maids_tasks_manager/src/features/authantication/domain/auth_response.dart';
import 'package:maids_tasks_manager/src/features/authantication/presentation/cubit/login_cubit.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthResponse extends Mock implements AuthResponse {
  @override
  String get token => 'mock_token';
}

class MockAppCubit extends Mock implements AppCubit {}

void main() {
  late LoginCubit loginCubit;
  late MockAuthRepository mockAuthRepository;
  late MockAppCubit mockAppCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAppCubit = MockAppCubit();
    loginCubit = LoginCubit();
  });

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      expect(loginCubit.state, equals(LoginInitial()));
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      build: () => loginCubit,
      act: (cubit) => cubit.login('eve.holt@reqres.in', 'cityslicka'),
      expect: () => [
        LoginLoading(),
        LoginSuccess(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails',
      build: () => loginCubit,
      act: (cubit) => cubit.login("eve.holet@reqres.in", "cityeslicka"),
      expect: () => [
        LoginLoading(),
        const LoginFailure(error: 'Login failed'),
      ],
    );

    tearDown(() {
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockAppCubit);
    });
  });
}
