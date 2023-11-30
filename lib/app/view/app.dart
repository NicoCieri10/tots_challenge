import 'package:app_client/app_client.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tots_challenge/home/home.dart';
import 'package:tots_challenge/l10n/l10n.dart';
import 'package:tots_challenge/login/login.dart';

class App extends StatefulWidget {
  const App({
    required this.dataPersistenceRepository,
    super.key,
  });

  final DataPersistenceRepository dataPersistenceRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = router(context);

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, __, ___) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AppClient>(
            create: (context) => AppClient(),
          ),
          RepositoryProvider(
            create: (context) => widget.dataPersistenceRepository,
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            fontFamily: 'DMSans',
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: _router.routerDelegate,
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
        ),
      ),
    );
  }

  GoRouter router(BuildContext context) {
    final isLoggedIn = widget.dataPersistenceRepository.isLoggedIn;

    return GoRouter(
      redirect: (context, state) {
        final isLoggedIn = widget.dataPersistenceRepository.isLoggedIn;
        if (!isLoggedIn) return LoginPage.route;

        return null;
      },
      initialLocation: isLoggedIn ? HomePage.route : LoginPage.route,
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
