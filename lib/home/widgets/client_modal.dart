import 'dart:io';

import 'package:app_client/app_client.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tots_challenge/common/common.dart';
import 'package:tots_challenge/l10n/l10n.dart';
import 'package:ui/ui.dart';

class ClientModal extends StatefulWidget {
  const ClientModal({this.client, super.key});

  final Client? client;

  @override
  State<ClientModal> createState() => _ClientModalState();
}

class _ClientModalState extends State<ClientModal> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final unfocus = FocusNode();
  final lastnameFocus = FocusNode();
  final emailFocus = FocusNode();

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      setState(() {
        _firstNameController.text = widget.client?.firstname ?? '';
        _lastNameController.text = widget.client?.lastname ?? '';
        _emailController.text = widget.client?.email ?? '';
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    unfocus.dispose();
    lastnameFocus.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientNull = widget.client == null;
    final focus = FocusScope.of(context);
    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Form(
          key: _formKey,
          child: Container(
            height: 380.sp,
            width: 220.sp,
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 15.sp,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFDF9),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Title(clientNull: clientNull),
                SizedBox(height: 25.sp),
                _ClientImage(
                  onTap: () => _picker
                      .pickImage(source: ImageSource.gallery)
                      .then((image) => setState(() => this.image = image)),
                  client: widget.client,
                  image: image,
                ),
                SizedBox(height: 11.sp),
                CustomTextField(
                  controller: _firstNameController,
                  hintText: context.l10n.firstName,
                  validator: (value) => Validators.emptyFieldValidator(
                    context: context,
                    value: value,
                  ),
                  onFieldSubmitted: (_) => focus.requestFocus(lastnameFocus),
                ),
                SizedBox(height: 11.sp),
                CustomTextField(
                  controller: _lastNameController,
                  focusNode: lastnameFocus,
                  hintText: context.l10n.lastName,
                  validator: (value) => Validators.emptyFieldValidator(
                    context: context,
                    value: value,
                  ),
                  onFieldSubmitted: (_) => focus.requestFocus(emailFocus),
                ),
                SizedBox(height: 11.sp),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocus,
                  controller: _emailController,
                  hintText: context.l10n.emailAddress,
                  validator: (value) => Validators.validateEmail(
                    context: context,
                    email: value,
                  ),
                  onFieldSubmitted: (_) => submit(),
                ),
                const Spacer(),
                _ButtonsRow(onPressed: submit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    final validForm = _formKey.currentState?.validate();
    FocusScope.of(context).requestFocus(FocusNode());
    if (validForm ?? false) {
      final client = Client(
        id: widget.client?.id,
        email: _emailController.text,
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
      );
      context.pop(client);
    }
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow({this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: context.pop,
          child: Text(
            context.l10n.cancel,
            style: TextStyle(
              color: const Color(0xFF080816).withOpacity(0.38),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CustomButton(
          onPressed: onPressed,
          height: 40,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              context.l10n.save,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.clientNull});

  final bool clientNull;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
        vertical: 5.sp,
      ),
      child: Text(
        clientNull ? context.l10n.addNewClient : context.l10n.editClient,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class _ClientImage extends StatelessWidget {
  const _ClientImage({
    this.onTap,
    this.client,
    this.image,
  });

  final void Function()? onTap;
  final Client? client;
  final XFile? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(43.5.sp),
          child: Container(
            width: 87.sp,
            height: 87.sp,
            alignment: Alignment.center,
            decoration: DottedDecoration(
              shape: Shape.circle,
              color: const Color(0xffE4F353),
            ),
            child: Builder(
              builder: (context) {
                final photo = client?.photo;
                if (!(client == null) && photo != null && photo.isNotEmpty) {
                  return Image.network(
                    client?.photo ?? '',
                    height: 87.sp,
                    width: 87.sp,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.person,
                      size: 87.sp,
                    ),
                  );
                }
                if (image != null) {
                  return SizedBox(
                    width: 87.sp,
                    height: 87.sp,
                    child: ClipOval(
                      child: Image.file(
                        File(image!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/landscape.svg',
                      height: 24.sp,
                    ),
                    SizedBox(height: 7.sp),
                    Text(
                      context.l10n.uploadImage,
                      style: TextStyle(
                        color: const Color(0xff080816).withOpacity(0.38),
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
