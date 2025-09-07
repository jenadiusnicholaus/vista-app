import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? initialCountryCode;
  final List<String>? countryCodes;
  final bool showCountryFlag;
  final bool showDropdownIcon;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;

  const CustomPhoneField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction,
    this.focusNode,
    this.initialCountryCode = 'US',
    this.countryCodes,
    this.showCountryFlag = true,
    this.showDropdownIcon = true,
    this.contentPadding,
    this.borderRadius,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _focusAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (_isFocused) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    _hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    Color borderColor = _hasError
        ? colorScheme.error
        : _isFocused
            ? colorScheme.primary
            : colorScheme.outline.withOpacity(0.3);

    Color fillColor = _isFocused
        ? colorScheme.primary.withOpacity(0.05)
        : colorScheme.surface;

    return AnimatedBuilder(
      animation: _focusAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.1),
                      blurRadius: 8.r,
                      offset: Offset(0, 2.h),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4.r,
                      offset: Offset(0, 1.h),
                    ),
                  ],
          ),
          child: IntlPhoneField(
            controller: widget.controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            autofocus: widget.autofocus,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            initialCountryCode: widget.initialCountryCode,
            disableLengthCheck: true,
            showCountryFlag: widget.showCountryFlag,
            showDropdownIcon: widget.showDropdownIcon,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            dropdownTextStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              helperText: widget.helperText,
              errorText: widget.errorText,
              filled: true,
              fillColor: fillColor,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
              labelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: _isFocused
                    ? colorScheme.primary
                    : colorScheme.onSurface.withOpacity(0.7),
              ),
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
              helperStyle: TextStyle(
                fontSize: 12.sp,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              errorStyle: TextStyle(
                fontSize: 12.sp,
                color: colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1.5.w,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                borderSide: BorderSide(
                  color: colorScheme.outline.withOpacity(0.3),
                  width: 1.5.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                borderSide: BorderSide(
                  color: colorScheme.primary,
                  width: 2.w,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 2.w,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 2.w,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                borderSide: BorderSide(
                  color: colorScheme.outline.withOpacity(0.2),
                  width: 1.w,
                ),
              ),
            ),
            validator: (phone) {
              if (widget.validator != null) {
                return widget.validator!(phone?.completeNumber);
              }
              return null;
            },
            onChanged: (phone) {
              if (widget.onChanged != null) {
                widget.onChanged!(phone.completeNumber);
              }
            },
            onSubmitted: (value) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(value);
              }
            },
            onTap: widget.onTap,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        );
      },
    );
  }
}
