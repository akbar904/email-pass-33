
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/user.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
	final User user;
	AuthAuthenticated(this.user);
}

class AuthError extends AuthState {
	final String message;
	AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());

			// Simulate network request
			await Future.delayed(Duration(seconds: 1));

			if (password == 'password') {
				final user = User(email: email, password: password);
				emit(AuthAuthenticated(user));
			} else {
				emit(AuthError('Login failed'));
			}
		} catch (e) {
			emit(AuthError(e.toString()));
		}
	}

	void logout() async {
		emit(AuthLoading());

		// Simulate network request
		await Future.delayed(Duration(seconds: 1));

		emit(AuthInitial());
	}
}
