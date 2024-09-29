
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cubit_app/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_app/cubits/auth_cubit.dart';

// Mocking AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => MockAuthCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.byKey(Key('emailField')), findsOneWidget);
			expect(find.byKey(Key('passwordField')), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => MockAuthCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.byKey(Key('loginButton')), findsOneWidget);
		});

		testWidgets('should display error message on login failure', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthState.error('Invalid credentials')]),
				initialState: AuthState.initial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: LoginScreen(),
					),
				),
			);

			await tester.pump();

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});

	group('AuthCubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthState.loading, AuthState.authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [
				AuthState.loading(),
				AuthState.authenticated(User(email: 'test@example.com', password: 'password123')),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthState.loading, AuthState.error] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [
				AuthState.loading(),
				AuthState.error('Invalid credentials'),
			],
		);
	});
}
