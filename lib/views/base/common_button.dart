
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vlr/services/theme.dart';

enum ButtonType {
  primary,
  secondary,
  tertiary,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.child,
    this.type = ButtonType.primary,
    required this.onTap,
    this.disabledColor,
    this.color,
    this.height = 45,
    this.isLoading = false,
    this.radius = 6,
    this.elevation = 0,
    this.fontSize = 16,
    this.textStyle,
    this.borderColor,
    this.borderWidth,
    this.gradient,
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.minWidth,
  }) : assert(
          title == null || child == null,
          'Cannot provide both a title and a child',
        );

  const CustomButton.tertiary({
    super.key,
    this.title,
    this.child,
    this.type = ButtonType.tertiary,
    required this.onTap,
    this.disabledColor,
    this.color,
    this.height = 45,
    this.isLoading = false,
    this.radius = 6,
    this.elevation = 0,
    this.fontSize,
    this.textStyle,
    this.borderColor,
    this.borderWidth,
    this.gradient,
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.minWidth,
  }) : assert(
          title == null || child == null,
          'Cannot provide both a title and a child',
        );

  // ============================================================
  // PROPERTIES
  // ============================================================

  final String? title;
  final Widget? child;
  final ButtonType type;

  final bool isLoading;

  final Color? disabledColor;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;

  final double? height;
  final double radius;

  final Function()? onTap;

  final double elevation;
  final double? fontSize;

  final TextStyle? textStyle;

  // ============================================================
  // GRADIENT
  // ============================================================

  final Gradient? gradient;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  // ============================================================
  // WIDTH
  // ============================================================

  /// Minimum width of the button.
  ///
  /// Example:
  /// minWidth: 180
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton(context);

      case ButtonType.secondary:
        return _buildSecondaryButton(context);

      case ButtonType.tertiary:
        return _buildTertiaryButton(context);
    }
  }

  // ============================================================
  // PRIMARY BUTTON
  // ============================================================

  Widget _buildPrimaryButton(BuildContext context) {
    final bool hasGradient = gradient != null;

    final Gradient? buttonGradient = isLoading ? null : gradient;

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(radius.r),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth?.w ?? 0,
        ),
        child: Ink(
          height: height?.h,
          decoration: BoxDecoration(
            color: isLoading
                ? disabledColor ?? Theme.of(context).disabledColor
                : hasGradient
                    ? null
                    : color ?? Theme.of(context).primaryColor,
            gradient: buttonGradient,
            borderRadius: BorderRadius.circular(radius.r),
            border: Border.all(
              color: borderColor ?? primaryColor,
              width: (borderWidth ?? 1).w,
            ),
          ),
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: BorderRadius.circular(radius.r),
            child: Center(
              child: _buildButtonContent(
                context,
                loadingColor: Colors.white,
                defaultTextColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECONDARY BUTTON
  // ============================================================

  Widget _buildSecondaryButton(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: borderColor ?? primaryColor,
      width: (borderWidth ?? 1).w,
    );

    return Material(
      color: Colors.transparent,
      elevation: elevation,
      borderRadius: BorderRadius.circular(radius.r),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth?.w ?? 0,
        ),
        child: Ink(
          height: height?.h,
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            borderRadius: BorderRadius.circular(radius.r),
            border: Border.fromBorderSide(borderSide),
          ),
          child: InkWell(
            onTap: isLoading ? null : onTap,
            borderRadius: BorderRadius.circular(radius.r),
            child: Center(
              child: _buildButtonContent(
                context,
                loadingColor: primaryColor,
                defaultTextColor: primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TERTIARY BUTTON
  // ============================================================

  Widget _buildTertiaryButton(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),
        minimumSize: minWidth != null
            ? Size(
                minWidth!.w,
                height?.h ?? 45.h,
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
      child: _buildButtonContent(
        context,
        loadingColor: Theme.of(context).primaryColor,
        defaultTextColor: Theme.of(context).primaryColor,
      ),
    );
  }

  // ============================================================
  // BUTTON CONTENT
  // ============================================================

  Widget _buildButtonContent(
    BuildContext context, {
    required Color loadingColor,
    required Color defaultTextColor,
  }) {
    // Loading
    if (isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.w,
        child: CircularProgressIndicator(
          color: loadingColor,
          strokeWidth: 2.w,
        ),
      );
    }

    // Custom child
    if (child != null) {
      return child!;
    }

    // Title
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: textStyle ??
            GoogleFonts.montserrat(
              color: defaultTextColor,
              fontSize: (fontSize ?? 16).sp,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
