
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays a logout button', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(null);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Logout'), findsOneWidget);
		});
		
		testWidgets('tapping logout button calls logout on AuthCubit', (WidgetTester tester) async {
			// Arrange
			final mockAuthCubit = MockAuthCubit();
			when(() => mockAuthCubit.state).thenReturn(null);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			// Act
			await tester.tap(find.byType(CustomButton));
			await tester.pump();

			// Assert
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
