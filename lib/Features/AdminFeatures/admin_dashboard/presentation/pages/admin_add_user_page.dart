import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:skb_cwd_app/config/page%20route/detail/route_name.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';

import '../../../../../constants/utils/auth_validator.dart';
import '../../../../../globalwidget/export.dart';
import '../bloc/cubit/admin_cubit.dart';

/////the page for admin to create and delete users


class AdminUsers extends StatelessWidget {
  const AdminUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final watchAdmin = context.watch<AdminCubit>();
    final allUsers = watchAdmin.allUsers;
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        isloading: watchAdmin.state is AdminLoadingState,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppCustomAppBar(title: 'User Stastics'),
              30.verticalSpace,
              AppshadowContainer(
                padding: EdgeInsets.all(size.width * 0.02),
                color: Appcolors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: '${allUsers.length}',
                            fontweight: FontWeight.w700,
                            size: 23,
                            color: Appcolors.white),
                        AppText(text: 'Active Users', color: Appcolors.white),
                      ],
                    ),
                    AppshadowContainer(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Icon(Icons.person_3_outlined, size: 20.sp),
                    )
                  ],
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  const AppText(
                      text: 'Create New User', fontweight: FontWeight.w700),
                  20.horizontalSpace,
                  AppshadowContainer(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const CreateUserModal();
                          });
                    },
                    shadowcolour: Appcolors.inActive,
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Icon(Icons.add, size: 20.sp),
                  )
                ],
              ),
              30.verticalSpace,
              const AppText(text: 'All Users', fontweight: FontWeight.w700),
              20.verticalSpace,
              Expanded(
                  child: ListView(
                      children: List.generate(
                          allUsers.length,
                          (index) => Padding(
                                padding:
                                    EdgeInsets.only(bottom: size.width * 0.03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                            text:
                                                '${allUsers[index].firstName} ${allUsers[index].lastName}',
                                            fontweight: FontWeight.w600),
                                        AppText(
                                            text: '${allUsers[index].email}'),
                                      ],
                                    ),
                                    AppshadowContainer(
                                      onTap: () {
                                        context
                                            .read<AdminCubit>()
                                            .admindeleteUsers(
                                                userId: allUsers[index].id);
                                      },
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      shadowcolour: Appcolors.inActive,
                                      child: Icon(Icons.delete,
                                          size: 20.sp,
                                          color: Appcolors.redColor),
                                    )
                                  ],
                                ),
                              ))))
            ],
          ),
        ));
  }
}

class AppCustomAppBar extends StatelessWidget {
  const AppCustomAppBar({super.key, required this.title, this.ontap});
  final String title;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppbackButton(onTap: ontap),
        AppText(text: title, fontweight: FontWeight.w600),
        const AppText(text: '')
      ],
    );
  }
}

class CreateUserModal extends StatefulWidget {
  const CreateUserModal({super.key});

  @override
  State<CreateUserModal> createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final watchAdmin = context.watch<AdminCubit>();
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminUserCreatedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomNav, (r) => false);
          context.read<AdminCubit>().adminGetAllUsers();
        }
      },
      child: AbsorbPointer(
        absorbing: watchAdmin.state is AdminLoadingState,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04, vertical: size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                      text: 'Create Account', fontweight: FontWeight.w500),
                  20.verticalSpace,
                  ApptextField(
                    controller: watchAdmin.userFirstName,
                    title: "Firstname",
                    prefixIcon: Icons.person,
                    validator: (v) => AuthValidator.validateName(v!),
                  ),
                  16.verticalSpace,
                  ApptextField(
                      validator: (v) => AuthValidator.validateName(v!),
                      controller: watchAdmin.userLastName,
                      title: "Lastname",
                      prefixIcon: Icons.person),
                  16.verticalSpace,
                  ApptextField(
                      validator: (v) => AuthValidator.validateEmail(v!),
                      controller: watchAdmin.userEmail,
                      title: "Email",
                      prefixIcon: Icons.email),
                  30.verticalSpace,
                  ApptextField(
                      validator: (v) =>
                          AuthValidator.validatePhoneNumber(value: v),
                      controller: watchAdmin.mobileNumber,
                      title: "Mobile Number",
                      prefixIcon: Icons.phone_android),
                  30.verticalSpace,
                  Appbutton(
                    isLoading: watchAdmin.state is AdminLoadingState,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AdminCubit>().createUser();
                      }
                    },
                    child: const AppText(
                        text: "Create", size: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
