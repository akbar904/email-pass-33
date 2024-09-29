
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.flutter_cubit_app/widgets/custom_button.dart';

void main() {
	group('CustomButton Widget Tests', () {
		testWidgets('displays the correct label', (WidgetTester tester) async {
			// Arrange
			const buttonLabel = 'Press Me';
			final button = CustomButton(
				label: buttonLabel,
				onPressed: () {},
			);

			// Act
			await tester.pumpWidget(MaterialApp(home: Scaffold(body: button)));

			// Assert
			expect(find.text(buttonLabel), findsOneWidget);
		});

		testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
			// Arrange
			var tapped = false;
			final button = CustomButton(
				label: 'Press Me',
				onPressed: () => tapped = true,
			);

			// Act
			await tester.pumpWidget(MaterialApp(home: Scaffold(body: button)));
			await tester.tap(find.byType(CustomButton));
			await tester.pump();

			// Assert
			expect(tapped, isTrue);
		});
	});
}
