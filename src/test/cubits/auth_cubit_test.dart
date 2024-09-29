
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		group('login', () {
			blocTest<AuthCubit, AuthState>(
				'Emits [AuthLoading, AuthAuthenticated] when login is successful',
				build: () => authCubit,
				act: (cubit) => cubit.login('test@example.com', 'password'),
				expect: () => [
					AuthLoading(),
					AuthAuthenticated(User(email: 'test@example.com', password: 'password')),
				],
			);

			blocTest<AuthCubit, AuthState>(
				'Emits [AuthLoading, AuthError] when login fails',
				build: () => authCubit,
				act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
				expect: () => [
					AuthLoading(),
					AuthError('Login failed'),
				],
			);
		});

		group('logout', () {
			blocTest<AuthCubit, AuthState>(
				'Emits [AuthLoading, AuthInitial] when logout is called',
				build: () => authCubit,
				act: (cubit) => cubit.logout(),
				expect: () => [
					AuthLoading(),
					AuthInitial(),
				],
			);
		});
	});
}
