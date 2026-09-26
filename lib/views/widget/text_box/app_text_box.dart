// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlr/services/constants.dart';
import 'package:vlr/services/input_decoration.dart';
import 'package:vlr/services/theme.dart';

class AppTextFieldWithHeading extends StatefulWidget {
  final TextEditingController controller;
  final String? heading;
  final Widget? headingWidget;

  /// Hint text
  final String hindText;

  /// Style for hint text
  final TextStyle? hintStyle;

  /// Style for entered text
  final TextStyle? textStyle;

  final String? prefixText;
  TextStyle? prefixStyle;
  final Widget? preFixWidget;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;

  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool isRequired;
  final bool readOnly;

  final Color? borderColor;
  final double? borderWidth;
  final Color? bgColor;

  final Function()? onTap;
  final double borderRadius;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  AppTextFieldWithHeading({
    super.key,
    required this.controller,
    required this.hindText,
    this.hintStyle,
    this.textStyle,
    this.validator,
    this.heading,
    this.headingWidget,
    this.keyboardType,
    this.suffix,
    this.prefixText,
    this.prefixStyle,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLines,
    this.preFixWidget,
    this.isRequired = false,
    this.readOnly = false,
    this.borderColor,
    this.borderWidth,
    this.bgColor,
    this.onTap,
    this.onChanged,
    this.borderRadius = 12.0,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  Color get borderColorLocal =>
      borderColor ??
      grey.withValues(
        alpha: 0.5,
      );

  Color get bgColorLocal =>
      bgColor ??
      grey.withValues(
        alpha: 0.1,
      );

  @override
  State<AppTextFieldWithHeading> createState() =>
      _AppTextFieldWithHeadingState();
}

class _AppTextFieldWithHeadingState extends State<AppTextFieldWithHeading> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final hintStyleLocal = widget.hintStyle ??
        Helper(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: greyText3,
            );

    /// If obscure text is enabled, force one line.
    final int effectiveMaxLines = _obscure ? 1 : (widget.maxLines ?? 1);

    /// Use custom suffix if provided.
    /// Otherwise show eye icon for password fields.
    final Widget? suffixWidget = widget.suffix ??
        (widget.obscureText
            ? IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading
        if (widget.heading != null || widget.headingWidget != null) ...[
          Row(
            children: [
              Expanded(
                child: widget.headingWidget ??
                    Text(
                      widget.heading!,
                      style: Helper(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: primaryText1,
                          ),
                    ),
              ),

              const SizedBox(width: 4),

              /// Required *
              if (widget.isRequired)
                Text(
                  "*",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                ),
            ],
          ),
          const SizedBox(height: 7),
        ],

        /// Text Field
        TextFormField(
          controller: widget.controller,

          textInputAction: widget.textInputAction ?? TextInputAction.next,

          onFieldSubmitted: widget.onFieldSubmitted,

          onTap: widget.onTap,

          keyboardType: widget.keyboardType,

          obscureText: _obscure,

          inputFormatters: widget.inputFormatters,

          maxLines: effectiveMaxLines,

          readOnly: widget.readOnly,

          onChanged: widget.onChanged,

          /// Entered text style
          style: widget.textStyle,

          /// Cursor color
          cursorColor: Colors.black,

          decoration: CustomDecoration.inputDecoration(
            borderRadius: widget.borderRadius,
            suffix: suffixWidget,
            icon: widget.preFixWidget,
            prefixText: widget.prefixText,
            prefixStyle: widget.prefixStyle,
            bgColor: widget.bgColorLocal,
            hint: widget.hindText,
            hintStyle: hintStyleLocal,
            borderColor: widget.borderColorLocal,
            borderWidth: widget.borderWidth ?? 0.5.w,
          ),

          validator: widget.validator,
        ),
      ],
    );
  }
}
