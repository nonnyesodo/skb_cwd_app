import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skb_cwd_app/Features/UserFeatures/home/data/model/shipmennt_zone_model.dart';
import 'package:skb_cwd_app/Features/UserFeatures/home/data/remote/home_repo.dart';
import 'package:skb_cwd_app/Features/UserFeatures/home/presentation/pages/user_home.dart';
import 'package:skb_cwd_app/constants/utils/toast_helper.dart';
import '../../../../AdminFeatures/admin_dashboard/presentation/pages/admin_dashboard.dart';
import '../../../auth/data/model/user_shipment_model.dart';
import '../../../auth/presentation/pages/login_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    fetchUserShipments();
    fetchShipmentZone();
  }

/////change bottom nav according to who is logedin 
  List<Widget> bottomnavScreen({isAdmin}) {
    if (isAdmin == false) {
      return [
        const UserHome(),
        const LoginPage(),
        const LoginPage(),
      ];
    } else {
      return [
        const AdminDashboard(),
        const LoginPage(),
        const LoginPage(),
      ];
    }
  }

  int bottonnavIndex = 0;
//////change bottom nav index
  changeBottomNav(value) {
    emit(HomeLoadingState());
    bottonnavIndex = value;
    emit(HomeLoadedState());
  }


//////////fetch user shipments and update ui 
  List<UserShipmentModel> userShipments = [];
  fetchUserShipments() async {
    emit(HomeLoadingState());
    try {
      final response = await homeRepo.fetchShipments();
      final body = jsonDecode(response.body);
      log(response.body.toString());
      if (response.statusCode == 200) {
        for (var ship in body['data']) {
          userShipments.add(UserShipmentModel.fromJson(ship));
        }
        emit(HomeLoadedState());
      } else {
        ToastMessage.showSuccessToast(message: body['message']);
        emit(HomeErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
    }
  }
  List<ShipmentZoneModel> shipmentZOnes = [];
  fetchShipmentZone() async {
    emit(HomeLoadingState());
    try {
      final response = await homeRepo.fetchShipmentZones();
      final body = jsonDecode(response.body);
      log(response.body.toString());
      if (response.statusCode == 200) {
          for (var zone in body['data']) {
          shipmentZOnes.add(ShipmentZoneModel.fromJson(zone));
        }
        emit(HomeLoadedState());
      } else {
        ToastMessage.showSuccessToast(message: body['message']);
        emit(HomeErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
    }
  }

/// user cancel shipment and update ui
  cancelUserShipments({shipmentId}) async {
    emit(HomeLoadingState());
    try {
      final response = await homeRepo.cancelShipment(shipmentId: shipmentId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(ShipmentcanceledState());
      } else {
        ToastMessage.showSuccessToast(message: body['message']);
        emit(HomeErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
    }
  }

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ////user confirm for shipment to be created
  confirmShipments() async {
    if (terms == false) {
      ToastMessage.showErrorToast(message: "Agree to terms");
      return;
    }
    emit(HomeLoadingState());

    try {
      final response = await homeRepo.confirmShipment();
      //
      log(response.body.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        ToastMessage.showErrorToast(message: 'Shipment Created');
        emit(ShipmentConfirmedState());
      } else {
        final body = jsonDecode(response.body);
        ToastMessage.showErrorToast(message: body['message']);
        emit(HomeErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
    }
  }


////user summit complain and update ui 
  userComplain({shipmentId}) async {
    emit(HomeLoadingState());
    try {
      final response = await homeRepo.userComplain();
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ToastMessage.showSuccessToast(message: body['message']);
        emit(HomeLoadedState());
      } else {
        ToastMessage.showSuccessToast(message: body['message']);
        emit(HomeErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
    }
  }

  String priorityLevel = '';
  String shipmentMode = '';
  String packageDescription = '';
  String carrier = '';
  String shippingMethod = '';
  String userCountry = '';
  String userState = '';
  String userCity = '';
  String userLga = '';
  String recieverCountry = '';
  String receiverLga = '';
  String receiverState = '';
  String receiverCity = '';
  DateTime? userPreferredPickupDatetime;
  DateTime? receiverPreferredDeliveryDatetime;
  bool insurance = false;
  bool hazardous = false;
  bool fragile = false;
  final numberOfPackages = TextEditingController();
  final shipmentValue = TextEditingController();
  final shipmentContent = TextEditingController();
  final userSpecialPickUpInstructions = TextEditingController();
  final receiverSpecialDeliveryInstructions = TextEditingController();
  final userPostalCode = TextEditingController();
  final userAddress = TextEditingController();
  final receiverName = TextEditingController();
  final receiverEmail = TextEditingController();
  final receiverMobile = TextEditingController();
  final receiverAddress = TextEditingController();
  final recieverPostalCode = TextEditingController();
  final height = TextEditingController();
  final width = TextEditingController();
  final weight = TextEditingController();
  String estimatedDeliveryDate = '';
  String totalCost = '';
  bool terms = false;
///get shipment delivery summary like estimated cost 
  createUserShipments({userName, userEmail, userMobile}) async {
    emit(HomeLoadingState());
    try {
      final response = await homeRepo.createShipment(
      
         );
      final body = jsonDecode(response.body);
      log("$body${response.statusCode}");
      if (response.statusCode == 200) {
        estimatedDeliveryDate =
            body['data']['estimatedDeliveryDate'].toString();
        totalCost = body['data']["total_cost"].toString();

        emit(HomeCreatedShipmentState());
      } else {
        ToastMessage.showErrorToast(message: body['message']);
        emit(HomeErrorState());
      }
    } catch (e) {
      log(e.toString());
      emit(HomeErrorState());
    }
  }

///stages of shipment creation
  final pageController = PageController(initialPage: 0);
  int verificationStage = 0;
  nextVerificationStage() {
    emit(HomeLoadingState());
    if (pageController.page!.toInt() == 1) {
      verificationStage = 1;
    } else if (pageController.page!.toInt() == 2) {
      verificationStage = 2;
    } else if (pageController.page!.toInt() == 3) {
      verificationStage = 3;
    }
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    emit(HomeLoadedState());
  }

  previousVerificationStage() {
    emit(HomeLoadingState());
    log(pageController.page!.toInt().toString());
    if (pageController.page!.toInt() == 0) {
      verificationStage = 1;
    } else if (pageController.page!.toInt() == 1) {
      verificationStage = 0;
    }
    if (pageController.page!.toInt() == 2) {
      verificationStage = 1;
    }
    pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    emit(HomeLoadedState());
  }

  changeState() {
    emit(HomeLoadingState());
    emit(HomeLoadedState());
  }

  List<File> invoice = [];
  List<File> msds = [];
  List<File> shipmentPicture = [];
  List<File> packingList = [];
  List<File> coa = [];
  List<File> others = [];
  ////upload shipment document for abroad shipment 
  uploadDoc({required String documentType}) async {
    emit(HomeLoadingState());
    log(documentType);
    final picker = ImagePicker();
    List<XFile> pickedFile = await picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      if (documentType == DocumentType.invoice.name) {
        for (var img in pickedFile) {
          log(img.path.toString());
          invoice.add(File(img.path));
        }
        
      } else if (documentType == DocumentType.coa.name) {
        for (var img in pickedFile) {
          coa.add(File(img.path));
        }
      } else if (documentType == DocumentType.msds.name) {
        for (var img in pickedFile) {
          msds.add(File(img.path));
        }
      } else if (documentType == DocumentType.others.name) {
        for (var img in pickedFile) {
          others.add(File(img.path));
        }
      } else if (documentType == DocumentType.shipmentPicture.name) {
        for (var img in pickedFile) {
          shipmentPicture.add(File(img.path));
        }
      } else if (documentType == DocumentType.packingList.name) {
        for (var img in pickedFile) {
          packingList.add(File(img.path));
        }
      }
    } else {
      ToastMessage.showErrorToast(message: 'select an image');
    }
    emit(HomeLoadedState());
  }
}

//enum to select document type 
enum DocumentType { invoice, msds, shipmentPicture, packingList, coa, others }
