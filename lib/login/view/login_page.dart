import 'package:app_client/app_client.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tots_challenge/common/validators.dart';
import 'package:tots_challenge/home/home.dart';
import 'package:tots_challenge/l10n/l10n.dart';
import 'package:tots_challenge/login/cubit/login_cubit.dart';
import 'package:ui/ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        appClient: context.read<AppClient>(),
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final unfocus = FocusNode();
  final passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    unfocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: GestureDetector(
          onTap: () => focus.requestFocus(unfocus),
          child: Scaffold(
            body: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) async {
                if (state.isBadCredentials) {
                  CustomSnackbar.showToast(
                    context: context,
                    status: SnackbarStatus.error,
                    title: context.l10n.badCredentials,
                  );
                } else if (state.isFailure) {
                  CustomSnackbar.showToast(
                    context: context,
                    status: SnackbarStatus.warning,
                    title: context.l10n.randomError,
                  );
                } else if (state.isSuccess) {
                  CustomSnackbar.showToast(
                    context: context,
                    status: SnackbarStatus.success,
                    title: context.l10n.loginSuccessfuly,
                  );
                  context.goNamed(HomePage.route);
                }
              },
              child: Stack(
                children: [
                  const BlurBackground(
                    elements: [
                      BackgroundElement(
                        svg: 'assets/top-right-vector.svg',
                        alignment: Alignment.topRight,
                      ),
                      BackgroundElement(
                        svg: 'assets/center-left-vector.svg',
                        alignment: Alignment.centerLeft,
                      ),
                      BackgroundElement(
                        svg: 'assets/bottom-center-vector.svg',
                        alignment: Alignment.bottomCenter,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 19),
                        const _LoginImage(),
                        SizedBox(height: 8.h),
                        Text(
                          context.l10n.login,
                          style: TextStyle(
                            letterSpacing: 2.5,
                            color: const Color(0xff0D1111).withOpacity(0.85),
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        CustomTextField(
                          controller: _emailController,
                          autofillHints: const [AutofillHints.email],
                          keyboardType: TextInputType.emailAddress,
                          hintText: context.l10n.mail,
                          validator: (value) => Validators.validateEmail(
                            email: value,
                            context: context,
                          ),
                          onFieldSubmitted: (_) =>
                              focus.requestFocus(passwordFocus),
                        ),
                        SizedBox(height: 3.h),
                        CustomTextField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          focusNode: passwordFocus,
                          hintText: context.l10n.password,
                          autofillHints: const [AutofillHints.password],
                          validator: (value) => Validators.validatePassword(
                            password: value,
                            context: context,
                          ),
                          onPressed: () => setState(
                            () => _isObscure = !_isObscure,
                          ),
                          onFieldSubmitted: (p0) => login(),
                        ),
                        SizedBox(height: 6.h),
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) {
                            return previous.isAttempting !=
                                current.isAttempting;
                          },
                          builder: (context, state) {
                            return CustomButton(
                              height: 40.sp,
                              loading: state.isAttempting,
                              onPressed: login,
                              child: Text(
                                context.l10n.login,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              ),
                            );
                          },
                        ),
                        const Spacer(flex: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<LoginCubit>().login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }
}

class _LoginImage extends StatelessWidget {
  const _LoginImage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Image.asset('assets/login-title.png'),
    );
  }
}
