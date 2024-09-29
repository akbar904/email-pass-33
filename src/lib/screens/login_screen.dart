
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_app/cubits/auth_cubit.dart';
import 'package:flutter_cubit_app/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
	@override
	_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocListener<AuthCubit, AuthState>(
				listener: (context, state) {
					if (state is AuthError) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(content: Text(state.message)),
						);
					} else if (state is AuthAuthenticated) {
						Navigator.pushReplacementNamed(context, '/home');
					}
				},
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							TextField(
								key: Key('emailField'),
								controller: _emailController,
								decoration: InputDecoration(labelText: 'Email'),
							),
							TextField(
								key: Key('passwordField'),
								controller: _passwordController,
								decoration: InputDecoration(labelText: 'Password'),
								obscureText: true,
							),
							SizedBox(height: 20),
							CustomButton(
								key: Key('loginButton'),
								label: 'Login',
								onPressed: () {
									final email = _emailController.text;
									final password = _passwordController.text;
									context.read<AuthCubit>().login(email, password);
								},
							),
						],
					),
				),
			),
		);
	}
}
