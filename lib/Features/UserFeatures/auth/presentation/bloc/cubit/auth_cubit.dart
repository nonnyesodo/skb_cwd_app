import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/data/model/user_model.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/data/repository/auth_repo.dart';
import 'package:skb_cwd_app/constants/api_constants.dart';
import 'package:skb_cwd_app/constants/utils/toast_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final userName = TextEditingController();
  UserModel user = UserModel();
  /////make api request to register and update the app ui
  registerUser() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.registerUser(
          password: password.text,
          phoneNumber: phoneNumber.text,
          firstName: firstName.text,
          lastName: lastName.text,
          email: email.text,
          userName: userName.text,
          confirmPasssword: confirmPassword.text);
      final body = jsonDecode(response.body);
      log("res${response.statusCode} body${response.body}");
      if (response.statusCode == 201) {
        user = UserModel.fromJson(body['data']);
        bearerToken = user.bearerToken ?? '';
        ToastMessage.showSuccessToast(message: body['message']);
        email.clear();
        password.clear();
        emit(AuthRegisteredState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AuthErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState());
    }
  }

/////make api request to login emit a state with the state navigate to approprate screen
  loginUser() async {
    emit(AuthLoadingState());
    try {
      final response =
          await authRepo.loginUser(password: password.text, email: email.text);
      final body = jsonDecode(response.body);
      log("res${response.statusCode} body${response.body}");
      if (response.statusCode == 200) {
        ToastMessage.showSuccessToast(message: body['message']);
        user = UserModel.fromJson(body['data']);
        bearerToken = user.bearerToken ?? '';
        if (user.isAdmin == true) {
          emit(AuthAdminState());
        } else {
          emit(AuthLoginState());
        }
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AuthErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AuthErrorState());
    }
  }
}
