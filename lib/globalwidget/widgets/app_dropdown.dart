import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:skb_cwd_app/constants/appcolors.dart';
import 'package:skb_cwd_app/globalwidget/export.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({
    super.key,
    required this.hintText,
    required this.onSelected,
    required this.values,
    this.validator,
    this.height,
    required this.title,
    required this.prefixIcon,
  }) : assert(values.length > 0 == true);
  final String hintText, title;
  final List<String> values;
  final void Function(String?)? onSelected;
  final String? Function(String?)? validator;
  final double? height;
  final IconData prefixIcon;
  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  bool showDropDown = false;

  @override
  Widget build(BuildContext context) {
    late Size size = MediaQuery.sizeOf(context);
    return PopUpOverlay(
      visible: showDropDown,
      offset: Offset(0, 67.h),
      onClose: () => setState(() => showDropDown = !showDropDown),
      modal: Container(
        height: widget.height,
        width: size.width * 0.88,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Appcolors.white,
          border: Border.all(color: Appcolors.inActive.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.values.length,
              (index) => _DropdownTile(
                title: widget.values[index],
                onTap: () {
                  setState(
                    () {
                      showDropDown = !showDropDown;
                    },
                  );
                  if (widget.onSelected != null) {
                    widget.onSelected!(widget.values[index]);
                  }
                },
              ),
            ),
          ),
        ),
      ),
      child: ApptextField(
        prefixIcon: widget.prefixIcon,
        title: widget.title,
        validator: widget.validator,
        hintText: widget.hintText,
        readOnly: true,
        onTap: () {
          setState(() {
            showDropDown = !showDropDown;
          });
        },
        sufixIcon: Icons.keyboard_arrow_down,
      ),
    );
  }
}

class _DropdownTile extends StatelessWidget {
  const _DropdownTile({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    late Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              AppText(
                text: title,
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class PopUpOverlay extends StatelessWidget {
  const PopUpOverlay({
    super.key,
    required this.visible,
    required this.onClose,
    required this.modal,
    required this.child,
    this.follower = Alignment.topLeft,
    this.target = Alignment.topLeft,
    this.offset = Offset.zero,
  });

  final Widget child;
  final Widget modal;
  final bool visible;
  final VoidCallback onClose;
  final Alignment follower;
  final Alignment target;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Barrier(
      visible: visible,
      onClose: onClose,
      child: PortalTarget(
        anchor: Aligned(
          follower: follower,
          target: target,
          offset: offset,
        ),
        visible: visible,
        closeDuration: kThemeAnimationDuration,
        portalFollower: TweenAnimationBuilder<double>(
          duration: kThemeAnimationDuration,
          curve: Curves.easeOut,
          tween: Tween(begin: 0, end: visible ? 1 : 0),
          builder: (context, progress, child) {
            return Transform(
              transform: Matrix4.translationValues(0, (1 - progress) * 50, 0),
              child: Opacity(
                opacity: progress,
                child: child,
              ),
            );
          },
          child: modal,
        ),
        child: child,
      ),
    );
  }
}

class Barrier extends StatelessWidget {
  const Barrier({
    super.key,
    required this.onClose,
    required this.visible,
    required this.child,
  });

  final Widget child;
  final VoidCallback onClose;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: visible,
      closeDuration: kThemeAnimationDuration,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClose,
        child: TweenAnimationBuilder<Color>(
          duration: kThemeAnimationDuration,
          tween: ColorTween(
            begin: Colors.transparent,
            end: Colors.transparent,
          ),
          builder: (context, color, child) {
            return ColoredBox(color: color);
          },
        ),
      ),
      child: child,
    );
  }
}

/// Non-nullable version of ColorTween
class ColorTween extends Tween<Color> {
  ColorTween({required Color begin, required Color end})
      : super(begin: begin, end: end);

  @override
  Color lerp(double t) => Color.lerp(begin, end, t)!;
}
