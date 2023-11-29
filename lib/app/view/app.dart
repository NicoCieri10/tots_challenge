import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_challenge/counter/counter.dart';
import 'package:tots_challenge/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = router(context);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
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
      // initialLocation: LoginPage.route,
      routes: <GoRoute>[
        // GoRoute(
        //   path: LoginPage.route,
        //   name: LoginPage.route,
        //   builder: (context, state) => LoginPage(key: state.pageKey),
        // ),
        // GoRoute(
        //   path: HomePage.route,
        //   name: HomePage.route,
        //   builder: (context, state) => HomePage(key: state.pageKey),
        // ),
      ],
    );
  }
}
