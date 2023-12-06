import 'package:app_client/app_client.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_challenge/home/cubit/home_cubit.dart';
import 'package:ui/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        appClient: context.read<AppClient>(),
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final unfocus = FocusNode();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(unfocus),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () => onLogout(context),
          child: const Icon(Icons.delete),
        ),
        body: const Stack(
          children: [
            BlurBackground(
              elements: [
                BackgroundElement(
                  svg: 'assets/top-left-vector.svg',
                  alignment: Alignment.topLeft,
                ),
                BackgroundElement(
                  svg: 'assets/center-right-vector.svg',
                  alignment: Alignment.centerRight,
                ),
                BackgroundElement(
                  svg: 'assets/bottom-right-vector.svg',
                  alignment: Alignment.bottomRight,
                ),
                BackgroundElement(
                  svg: 'assets/bottom-left-vector.svg',
                  alignment: Alignment.bottomLeft,
                ),
              ],
            ),
            Center(
              child: Column(
                children: [Text('home')],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onLogout(BuildContext context) async {
    await context.read<HomeCubit>().logout();
    if (!mounted) return;
    context.goNamed('/login');
  }
}
