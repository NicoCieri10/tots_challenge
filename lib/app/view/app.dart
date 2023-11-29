import 'package:app_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_challenge/home/home.dart';
import 'package:tots_challenge/l10n/l10n.dart';
import 'package:tots_challenge/login/login.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = router(context);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppClient>(
          create: (context) => AppClient(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
      ),
    );
  }

  GoRouter router(BuildContext context) {
    // final isLogged = widget.dataPersistenceRepository.isLoggedIn;

    return GoRouter(
      // redirect: (context, state) {
      //   final isLogged = widget.dataPersistenceRepository.isLoggedIn;
      //   if (!isLogged) {
      //     return LoginPage.route;
      //   }
      //   return null;
      // },
      initialLocation: LoginPage.route,
      routes: <GoRoute>[
        GoRoute(
          path: LoginPage.route,
          name: LoginPage.route,
          builder: (context, state) => LoginPage(key: state.pageKey),
        ),
        GoRoute(
          path: HomePage.route,
          name: HomePage.route,
          builder: (context, state) => HomePage(key: state.pageKey),
        ),
      ],
    );
  }
}
