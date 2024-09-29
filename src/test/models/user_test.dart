
import 'package:flutter_test/flutter_test.dart';
import 'package:lib/models/user.dart';

void main() {
	group('User Model Tests', () {
		test('User model should be instantiated with correct email and password', () {
			final user = User(email: 'test@example.com', password: 'password123');
			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('User model should be correctly serialized to JSON', () {
			final user = User(email: 'test@example.com', password: 'password123');
			final userJson = user.toJson();
			expect(userJson, {'email': 'test@example.com', 'password': 'password123'});
		});

		test('User model should be correctly deserialized from JSON', () {
			final userJson = {'email': 'test@example.com', 'password': 'password123'};
			final user = User.fromJson(userJson);
			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});
	});
}
