import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';

import '../../../../../globalwidget/export.dart';
/////page for user to report an issue 
class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

final discribeIssueController = TextEditingController();
final subjectController = TextEditingController();
File? selectedImages;

class _ReportIssueState extends State<ReportIssue> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
        body: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppbackButton(),
            AppText(text: 'Report An Issue'),
            AppText(text: 'text')
          ],
        ),
        const AppText(
            text: 'To report an issue, please fill the form below', size: 12),
        20.verticalSpace,
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ApptextField(
                  controller: subjectController,
                  title: 'Subject',
                ),
                20.verticalSpace,
                ApptextField(
                  controller: discribeIssueController,
                  title: 'Tell us the problem that you’re facing',
                ),
                20.verticalSpace,
                const AppText(text: 'Add a screenshot', size: 16),
                10.verticalSpace,
                IssueImageBox(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      // Do something with the selected images
                      if (image != null) {
                        selectedImages = File(image.path);
                      }
                    });
                  },
                ),
                20.verticalSpace,
                selectedImages != null
                    ? Image.file(
                        selectedImages!,
                        height: 150.h,
                        width: 150.h,
                        fit: BoxFit.contain,
                      )
                    : const SizedBox.shrink(),
                50.verticalSpace,
                Appbutton(label: 'Submit', onTap: () {})
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class IssueImageBox extends StatelessWidget {
  const IssueImageBox({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        strokeWidth: 1,
        color: Appcolors.lightBlack,
        dashPattern: const [8, 4],
        child: Container(
          height: 80.h,
          width: 85.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.green,
            size: 30,
          ),
        ),
      ),
    );
  }
}
