import 'package:app_client/app_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tots_challenge/home/cubit/home_cubit.dart';
import 'package:tots_challenge/home/widgets/widgets.dart';
import 'package:tots_challenge/l10n/l10n.dart';

enum PopupOptions {
  edit,
  delete,
}

class ClientCard extends StatelessWidget {
  const ClientCard(this.client, {super.key});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.sp),
      padding: EdgeInsets.only(
        left: 11.sp,
        right: 4.sp,
        top: 16.sp,
        bottom: 16.sp,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        children: [
          _ClientImage(client),
          SizedBox(width: 10.sp),
          _ClientInfo(client),
          const Spacer(),
          _MenuButton(client),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return PopupMenuButton(
      color: Colors.black,
      onSelected: (PopupOptions option) async {
        if (option == PopupOptions.edit) {
          await showDialog<Client?>(
            barrierColor: Colors.transparent,
            context: context,
            builder: (_) => ClientModal(client: client),
          ).then((client) {
            if (client != null) cubit.updateClient(client);
          });
        } else {
          await cubit.deleteClient(client);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<PopupOptions>(
          height: 26.sp,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          value: PopupOptions.edit,
          child: _MenuTile(
            icon: Icons.edit,
            text: context.l10n.edit,
          ),
        ),
        PopupMenuItem<PopupOptions>(
          height: 26.sp,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          value: PopupOptions.delete,
          child: _MenuTile(
            icon: Icons.delete,
            text: context.l10n.delete,
          ),
        ),
      ],
    );
  }
}

class _ClientImage extends StatelessWidget {
  const _ClientImage(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.5.sp,
      width: 36.5.sp,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36.5.sp),
        child: CircleAvatar(
          child: Image.network(
            client.photo ?? '',
            height: 36.5.sp,
            width: 36.5.sp,
            errorBuilder: (_, __, ___) => Icon(
              Icons.person,
              size: 36.5.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _ClientInfo extends StatelessWidget {
  const _ClientInfo(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${client.firstname} ${client.lastname}',
            style: TextStyle(
              color: const Color(0xff0D0D0D),
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            client.email ?? '',
            style: TextStyle(
              color: const Color(0xff434545),
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Colors.white,
        ),
        SizedBox(width: 5.sp),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
