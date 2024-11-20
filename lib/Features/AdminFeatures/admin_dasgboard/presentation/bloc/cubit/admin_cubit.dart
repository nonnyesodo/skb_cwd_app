import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skb_cwd_app/Features/AdminFeatures/admin_dasgboard/data/model/admin_user_model.dart';
import 'package:skb_cwd_app/Features/AdminFeatures/admin_dasgboard/data/remote/admin_repo.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/data/model/user_shipment_model.dart';
import 'package:skb_cwd_app/constants/utils/toast_helper.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminRepo adminRepo;
  AdminCubit(this.adminRepo) : super(AdminInitial()) {
    adminGetAllUsers();
  }

  final userFirstName = TextEditingController();
  final userLastName = TextEditingController();
  final userEmail = TextEditingController();
  final mobileNumber = TextEditingController();
//////function to create user by admin make request and update the ui 
  createUser() async {
    emit(AdminLoadingState());
    try {
      final response = await adminRepo.adminCreateUser(
          firstName: userFirstName.text,
          lastName: userLastName.text,
          mobileNumber: mobileNumber.text,
          email: userEmail.text);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessage.showSuccessToast(message: body['message']);
        userEmail.clear();
        userFirstName.clear();
        userLastName.clear();
        emit(AdminUserCreatedState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AdminErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AdminErrorState());
    }
  }

//////function to fetch  shipement  by admin based on status, make request and update the ui 
  List<UserShipmentModel> approvedShipments = [];
  List<UserShipmentModel> pendingShipments = [];
  fetchShipment({status}) async {
    emit(AdminLoadingState());
    try {
      final response = await adminRepo.fetchShipments(status: status);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log(status);
        if (status.toString() == 'Pending') {
          log(response.body.toString());
          pendingShipments.clear();
          for (var ship in body['data']) {
            pendingShipments.add(UserShipmentModel.fromJson(ship));
          }
        } else {
          approvedShipments.clear();
          for (var ship in body['data']) {
            approvedShipments.add(UserShipmentModel.fromJson(ship));
          }
          log(approvedShipments.length.toString());
        }

        emit(AdminUserCreatedState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AdminErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AdminErrorState());
    }
  }

//////function to fetch user by admin make request and update the ui 
  List<AdminUsersModel> allUsers = [];
  adminGetAllUsers() async {
    emit(AdminLoadingState());
    try {
      final response = await adminRepo.adminGetUsers();
      final body = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        allUsers.clear();
        for (var users in body) {
          allUsers.add(AdminUsersModel.fromJson(users));
        }
        emit(AdminLoadedState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AdminErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AdminErrorState());
    }
  }

//////function to delete user by admin make request and update the ui 
  admindeleteUsers({userId}) async {
    emit(AdminLoadingState());
    try {
      final response = await adminRepo.adminDeleteUser(userId: userId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        allUsers.removeWhere((e) => e.id == userId);
        emit(AdminLoadedState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AdminErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AdminErrorState());
    }
  }

//////function to accept shipment by admin make request and update the ui 
  adminAcceptShipment({shipmentId}) async {
    emit(AdminLoadingState());
    try {
      final response =
          await adminRepo.adminApprovedShipment(shipmentId: shipmentId);
      final body = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        ToastMessage.showSuccessToast(message: body['message']);
        pendingShipments.removeWhere((e) => e.id == shipmentId);
        emit(AdminLoadedState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AdminErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AdminErrorState());
    }
  }

//////function to reject shipment by admin make request and update the ui 
  adminRejectShipment({shipmentId}) async {
    emit(AdminLoadingState());
    try {
      final response =
          await adminRepo.adminRejectShipment(shipmentId: shipmentId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ToastMessage.showErrorToast(message: body['message']);
        pendingShipments.removeWhere((e) => e.id == shipmentId);
        emit(AdminLoadedState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(AdminErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(AdminErrorState());
    }
  }
}
