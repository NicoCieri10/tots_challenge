import 'package:app_client/app_client.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tots_challenge/home/cubit/home_cubit.dart';
import 'package:tots_challenge/home/widgets/widgets.dart';
import 'package:tots_challenge/l10n/l10n.dart';
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
      )..init(),
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
  final unfocus = FocusNode();

  @override
  void dispose() {
    unfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(unfocus),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () => onLogout(context),
          child: const Icon(Icons.exit_to_app_rounded),
        ),
        body: const Stack(
          children: [
            _HomeBackground(),
            _HomeBody(),
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

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isFailure) {
          CustomSnackbar.showToast(
            context: context,
            status: SnackbarStatus.warning,
            title: context.l10n.randomError,
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          color: Colors.black,
          onRefresh: context.read<HomeCubit>().refresh,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 8.w,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/login-title.png',
                    width: 94.sp,
                  ),
                  SizedBox(height: 2.5.h),
                  Row(
                    children: [
                      Text(
                        context.l10n.clients,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff434545),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SearchWidget(),
                      _NewClientButton(),
                    ],
                  ),
                  if (!state.isFailure)
                    _ClientList(state: state)
                  else
                    const _RefreshWidget(),
                  const _LoadMoreButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Padding(
      padding: EdgeInsets.only(
        bottom: 1.5.h,
        left: 3.w,
        right: 3.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2D2C83).withOpacity(0.20),
              offset: const Offset(0, 4),
              blurRadius: 15,
            ),
          ],
        ),
        child: CustomButton(
          onPressed: () => cubit.getMoreClients(cubit.state.page + 1),
          height: 40.sp,
          child: Text(
            context.l10n.loadMore,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _NewClientButton extends StatelessWidget {
  const _NewClientButton();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D2C83).withOpacity(0.20),
            offset: const Offset(0, 4),
            blurRadius: 15,
          ),
        ],
      ),
      child: CustomButton(
        height: 22.sp,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Text(
            context.l10n.addNew,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
            ),
          ),
        ),
        onPressed: () async {
          await showDialog<Client?>(
            barrierColor: Colors.transparent,
            context: context,
            builder: (_) => const ClientModal(),
          ).then((client) {
            if (client != null) cubit.createClient(client);
          });
        },
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.sp,
      width: 170.sp,
      child: TextFormField(
        onChanged: (value) => context.read<HomeCubit>().searchClient(value),
        decoration: InputDecoration(
          hintText: '${context.l10n.search}...',
          hintStyle: TextStyle(
            color: const Color(0xff434545),
            fontSize: 10.sp,
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xff434545),
            size: 14.sp,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 3.sp),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.75),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(54.sp),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xff1F1D2B).withOpacity(0.61),
            ),
            borderRadius: BorderRadius.circular(54.sp),
          ),
        ),
      ),
    );
  }
}

class _ClientList extends StatelessWidget {
  const _ClientList({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    if (state.isAttempting || state.isLoadingMore) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
      );
    }

    final clients = state.filteredClients;

    if (clients.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            context.l10n.noClientsFound,
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: clients.length,
        itemBuilder: (context, index) => ClientCard(clients[index]),
      ),
    );
  }
}

class _RefreshWidget extends StatelessWidget {
  const _RefreshWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            context.l10n.randomError,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        TextButton(
          onPressed: context.read<HomeCubit>().refresh,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.refreshClients.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueAccent,
                ),
              ),
              const Icon(
                Icons.refresh,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return const BlurBackground(
      elements: [
        BackgroundElement(
          svg: 'assets/top-left-vector.svg',
          alignment: Alignment.topLeft,
        ),
        BackgroundElement(
          svg: 'assets/center-right-vector.svg',
          alignment: Alignment(1, -0.3),
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
    );
  }
}
