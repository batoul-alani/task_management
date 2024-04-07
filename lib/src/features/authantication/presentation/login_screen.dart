import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_tasks_manager/src/features/authantication/presentation/cubit/login_cubit.dart';
import 'package:maids_tasks_manager/src/features/authantication/presentation/widgets/password_form_field.dart';
import 'package:maids_tasks_manager/src/injection_container.dart';
import 'package:maids_tasks_manager/src/routing/app_router.gr.dart';
import 'package:maids_tasks_manager/src/shared_cubits/app/app_cubit.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  String _email = "";
  String _password = "";

  final double height = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppCubit, AppState>(
        listenWhen: (previus, next) => previus != next,
        listener: (context, state) {
          if (state is Authenticated) {
            context.replaceRoute(const TasksRoute());
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                        onSaved: (value) => _email = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else if (!value.contains("@") ||
                              !value.contains(".")) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: "Email Address")),
                    SizedBox(height: height),
                    PasswordFormField(
                        onSaved: (value) => _password = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        onChanged: null,
                        hintText: "Password"),
                    SizedBox(height: height * 2),
                    BlocProvider(
                      create: (_) => getIt<LoginCubit>(),
                      child: BlocConsumer<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return state is LoginLoading
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    _globalKey.currentState!.save();
                                    if (_globalKey.currentState!.validate()) {
                                      context
                                          .read<LoginCubit>()
                                          .login(_email, _password);
                                    }
                                  },
                                  child: const Text("Login"));
                        },
                        listenWhen: (previus, next) => previus != next,
                        listener: (BuildContext context, LoginState state) {
                          if (state is LoginSuccess) {
                            context.replaceRoute(const TasksRoute());
                          } else if (state is LoginFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)));
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
