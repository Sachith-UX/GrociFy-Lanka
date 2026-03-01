import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';

enum ButtonVariant {
  primary,
  secondary,
  outlined,
  text,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonStyle = _getButtonStyle(theme);
    final buttonSize = _getButtonSize();

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? buttonSize.height,
      child: ElevatedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: buttonStyle,
        child: _buildContent(),
      ),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          disabledBackgroundColor: theme.colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
          ),
        );

      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: theme.colorScheme.onSecondary,
          disabledBackgroundColor: theme.colorScheme.onSurface.withOpacity(0.12),
          disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
          ),
        );

      case ButtonVariant.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          side: BorderSide(color: theme.colorScheme.primary),
          disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
          ),
        );

      case ButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
          ),
        );
    }
  }

  _ButtonSize _getButtonSize() {
    switch (size) {
      case ButtonSize.small:
        return _ButtonSize(
          height: AppSizes.buttonHeightSM,
          fontSize: AppSizes.fontSizeSM,
        );
      case ButtonSize.medium:
        return _ButtonSize(
          height: AppSizes.buttonHeightMD,
          fontSize: AppSizes.fontSizeMD,
        );
      case ButtonSize.large:
        return _ButtonSize(
          height: AppSizes.buttonHeightLG,
          fontSize: AppSizes.fontSizeLG,
        );
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: _getButtonSize().fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          trailingIcon!,
        ],
      ],
    );
  }
}

class _ButtonSize {
  final double height;
  final double fontSize;

  _ButtonSize({required this.height, required this.fontSize});
}