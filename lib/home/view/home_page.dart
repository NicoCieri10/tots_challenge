import 'package:app_client/app_client.dart';
import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:tots_challenge/home/cubit/home_cubit.dart';
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
  @override
  void initState() {
    super.initState();
    // context.read<HomeCubit>().getClients();
  }

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
        body: Stack(
          children: [
            const _HomeBackground(),
            BlocConsumer<HomeCubit, HomeState>(
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
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Text(
                                context.l10n.clients,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff434545),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //       height: AppSize(context).pixels(42),
                          //       width: AppSize(context).pixels(220),
                          //       child: TextFormField(
                          //         onChanged: (value) {
                          //           setState(() {
                          //             query = value;
                          //             if (value.isEmpty) {
                          //               clients = state.clients;
                          //             } else {
                          //               clients = state.clients
                          //                   .where(
                          //                     (client) =>
                          //                         (client.firstname ?? '')
                          //                             .toLowerCase()
                          //                             .contains(
                          //                               value.toLowerCase(),
                          //                             ) ||
                          //                         (client.lastname ?? '')
                          //                             .toLowerCase()
                          //                             .contains(
                          //                               value.toLowerCase(),
                          //                             ) ||
                          //                         (client.email ?? '')
                          //                             .toLowerCase()
                          //                             .contains(
                          //                               value.toLowerCase(),
                          //                             ),
                          //                   )
                          //                   .toList();
                          //             }
                          //             if (clients.length > 5) {
                          //               clientsShowed = 5;
                          //               noMoreClients = false;
                          //             } else {
                          //               clientsShowed = clients.length;
                          //               noMoreClients = true;
                          //             }
                          //           });
                          //         },
                          //         decoration: InputDecoration(
                          //           hintText: '${context.l10n.search}...',
                          //           fillColor: Colors.white,
                          //           filled: true,
                          //           prefixIcon: const Icon(
                          //             Icons.search,
                          //             color: Color(0xff434545),
                          //           ),
                          //           contentPadding: EdgeInsets.symmetric(
                          //             vertical: AppSize(context).pixels(12),
                          //           ),
                          //           focusedBorder: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color: Colors.black.withOpacity(0.75),
                          //               width: 1.5,
                          //             ),
                          //             borderRadius: BorderRadius.circular(
                          //               AppSize(context).pixels(70),
                          //             ),
                          //           ),
                          //           border: OutlineInputBorder(
                          //             borderSide: BorderSide(
                          //               color:
                          //                   const Color(0xff1F1D2B).withOpacity(
                          //                 0.61,
                          //               ),
                          //             ),
                          //             borderRadius: BorderRadius.circular(
                          //               AppSize(context).pixels(70),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     CustomButton(
                          //       height: 25.sp,
                          //       // width: 80.sp,
                          //       title: context.l10n.addNew,
                          //       onPressed: () async {
                          //         await showDialog<Client?>(
                          //           barrierColor: Colors.transparent,
                          //           context: context,
                          //           builder: (BuildContext innerContext) {
                          //             return const ClientModal();
                          //           },
                          //         ).then((client) {
                          //           if (client != null) {
                          //             context
                          //                 .read<HomeCubit>()
                          //                 .createClient(client);
                          //           }
                          //         });
                          //       },
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 2.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.clients.length,
                              itemBuilder: (context, index) {
                                final client = state.clients[index];

                                return ListTile(
                                  dense: true,
                                  title: Text(
                                    client.firstname ?? 'N/D',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(client.email ?? 'N/D'),
                                );
                                // return ClientCard(
                                //   client: client,
                                //   onTap: () async {
                                //     await showDialog<Client?>(
                                //       barrierColor: Colors.transparent,
                                //       context: context,
                                //       builder: (BuildContext innerContext) {
                                //         return ClientModal(
                                //           client: client,
                                //         );
                                //       },
                                //     ).then((client) {
                                //       if (client != null) {
                                //         context
                                //             .read<HomeCubit>()
                                //             .updateClient(client);
                                //       }
                                //     });
                                //   },
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
    );
  }
}
