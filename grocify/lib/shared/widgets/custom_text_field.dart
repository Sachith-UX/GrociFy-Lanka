import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_sizes.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputAction? textInputAction;
  final bool readOnly;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textInputAction,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: widget.enabled
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withOpacity(0.38),
            ),
          ),
          const SizedBox(height: AppSizes.xs),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          obscureText: _obscureText,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          autocorrect: widget.autocorrect,
          enableSuggestions: widget.enableSuggestions,
          textInputAction: widget.textInputAction,
          readOnly: widget.readOnly,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: widget.enabled
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withOpacity(0.38),
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffixIcon(),
            filled: true,
            fillColor: widget.enabled
                ? theme.colorScheme.surface
                : theme.colorScheme.surface.withOpacity(0.12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
              borderSide: BorderSide(
                color: theme.colorScheme.onSurface.withOpacity(0.12),
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMD,
              vertical: AppSizes.paddingMD,
            ),
          ),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator,
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    if (widget.suffixIcon != null) {
      if (widget.onSuffixIconPressed != null) {
        return IconButton(
          icon: widget.suffixIcon!,
          onPressed: widget.onSuffixIconPressed,
        );
      }
      return widget.suffixIcon;
    }

    return null;
  }
}