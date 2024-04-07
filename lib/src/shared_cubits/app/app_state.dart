part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

final class AuthInitial extends AppState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Unauthenticated extends AppState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Authenticated extends AppState {
  final String token;

  const Authenticated(this.token);
  @override
  List<Object> get props => [token];
}
