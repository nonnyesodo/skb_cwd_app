import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:skb_cwd_app/Features/UserFeatures/home/presentation/cubit/home_cubit.dart';

import '../../../../../constants/appcolors.dart';
import '../../../../../globalwidget/export.dart';
import '../../../../AdminFeatures/admin_dashboard/presentation/pages/admin_add_user_page.dart';
///page to summit document if shipment is abroad
class ShipmentDocumentPage extends StatelessWidget {
  const ShipmentDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final readHome = context.read<HomeCubit>();
    final watchHome = context.watch<HomeCubit>();
    return AppScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          children: [
            const AppCustomAppBar(title: 'Shipment Document'),
            10.verticalSpace,
            const AppText(
                text:
                    'Provide the Following Documnents for international shipments',
                size: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DocumentUploadWidget(
                        ontapCancel: () {
                          watchHome.invoice.clear();
                          readHome.changeState();
                        },
                        image: watchHome.invoice.isNotEmpty
                            ? watchHome.invoice.first
                            : null,
                        ontap: () => readHome.uploadDoc(
                            documentType: DocumentType.invoice.name),
                        title: 'Invoice',
                        hintText: 'Upload Item Invoice'),
                    DocumentUploadWidget(
                        ontapCancel: () {
                          watchHome.msds.clear();
                          readHome.changeState();
                        },
                        image: watchHome.msds.isNotEmpty
                            ? watchHome.msds.first
                            : null,
                        ontap: () => readHome.uploadDoc(
                            documentType: DocumentType.msds.name),
                        title: 'MSDS',
                        hintText:
                            'Upload Safety Datasheet For \nChemicals or Manufactured product'),
                    DocumentUploadWidget(
                        ontapCancel: () {
                          watchHome.shipmentPicture.clear();
                          readHome.changeState();
                        },
                        image: watchHome.shipmentPicture.isNotEmpty
                            ? watchHome.shipmentPicture.first
                            : null,
                        ontap: () => readHome.uploadDoc(
                            documentType: DocumentType.shipmentPicture.name),
                        title: 'Pictures Of Shipments',
                        hintText: 'Upload Photo of Shipments'),
                    DocumentUploadWidget(
                        ontapCancel: () {
                          watchHome.packingList.clear();
                          readHome.changeState();
                        },
                        image: watchHome.packingList.isNotEmpty
                            ? watchHome.packingList.first
                            : null,
                        ontap: () => readHome.uploadDoc(
                            documentType: DocumentType.packingList.name),
                        title: 'Packing List',
                        hintText: 'Upload Packing List'),
                    DocumentUploadWidget(
                        ontapCancel: () {
                          watchHome.coa.clear();
                          readHome.changeState();
                        },
                        image: watchHome.coa.isNotEmpty
                            ? watchHome.coa.first
                            : null,
                        ontap: () => readHome.uploadDoc(
                            documentType: DocumentType.coa.name),
                        title: 'COA',
                        hintText: 'Upload If Product is Chemical'),
                    DocumentUploadWidget(
                        ontapCancel: () {
                          watchHome.others.clear();
                          readHome.changeState();
                        },
                        image: watchHome.others.isNotEmpty
                            ? watchHome.others.first
                            : null,
                        ontap: () => readHome.uploadDoc(
                            documentType: DocumentType.others.name),
                        title: 'Others',
                        hintText: 'Upload Optonal'),
                    20.verticalSpace,
                    const Appbutton(
                      label: 'Confirm',
                    ),
                    20.verticalSpace
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentUploadWidget extends StatelessWidget {
  const DocumentUploadWidget(
      {super.key,
      required this.title,
      required this.hintText,
      this.ontap,
      this.image,
      this.ontapCancel});
  final String title, hintText;
  final Function()? ontap, ontapCancel;
  final File? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(text: title, fontweight: FontWeight.w600),
        AppshadowContainer(
            padding: EdgeInsets.all(10.w),
            onTap: ontap,
            border: true,
            borderColor: Appcolors.green,
            child: image != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(image!,
                          height: 200.h, width: 200.h, fit: BoxFit.cover),
                      10.horizontalSpace,
                      GestureDetector(
                        onTap: ontapCancel,
                        child: Icon(Icons.cancel_outlined,
                            size: 30.sp, color: Appcolors.redColor),
                      )
                    ],
                  )
                : Column(
                    children: [
                      AppText(
                          text: hintText,
                          size: 16,
                          textalign: TextAlign.center),
                      Icon(Icons.cloud_upload, size: 50.sp),
                      const AppText(text: 'Tap To Upload'),
                    ],
                  )),
        20.verticalSpace,
      ],
    );
  }
}
