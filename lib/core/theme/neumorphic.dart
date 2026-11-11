import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Neumorphic design primitives and Indian National Congress (INC) brand tokens.

/// Congress Emblem (Abhay Mudra - अभय मुद्रा / The Open Palm of Congress)
/// Enclosed in a dignified medallion with a circular Indian Tricolor ring.
class CongressEmblem extends StatelessWidget {
  const CongressEmblem({
    super.key,
    this.size = 42,
    this.showTricolorRing = true,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.partyBlue,
    this.showShadow = true,
  });

  final double size;
  final bool showTricolorRing;
  final Color backgroundColor;
  final Color iconColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final ringWidth = size > 40 ? 3.0 : 2.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.9),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: const Color(0x30135A91),
                  offset: const Offset(2, 3),
                  blurRadius: 6,
                ),
              ]
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showTricolorRing)
            CustomPaint(
              size: Size(size, size),
              painter: _TricolorRingPainter(strokeWidth: ringWidth),
            ),
          Center(
            child: ClipOval(
              child: Image.asset(
                'assets/logos/inc_logo.png',
                width: size * 0.72,
                height: size * 0.72,
                cacheWidth: (size * 2).round(),
                cacheHeight: (size * 2).round(),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.back_hand, size: size * 0.52, color: iconColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Official Rajiv Gandhi Panchayati Raj Sangathan (RGPRS) Emblem.
class RgprsEmblem extends StatelessWidget {
  const RgprsEmblem({
    super.key,
    this.size = 42,
    this.backgroundColor = Colors.white,
    this.showShadow = true,
  });

  final double size;
  final Color backgroundColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.9),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                ),
                BoxShadow(
                  color: const Color(0x30135A91),
                  offset: const Offset(2, 3),
                  blurRadius: 6,
                ),
              ]
            : null,
      ),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/logos/rgprs_logo.png',
            width: size * 0.85,
            height: size * 0.85,
            cacheWidth: (size * 2).round(),
            cacheHeight: (size * 2).round(),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.account_balance,
              size: size * 0.52,
              color: AppColors.partyBlue,
            ),
          ),
        ),
      ),
    );
  }
}

/// Dual Party Header with INC and RGPRS Logos side by side.
class DualPartyEmblem extends StatelessWidget {
  const DualPartyEmblem({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CongressEmblem(size: size, showShadow: false),
        const SizedBox(width: 8),
        RgprsEmblem(size: size, showShadow: false),
      ],
    );
  }
}

class _TricolorRingPainter extends CustomPainter {
  const _TricolorRingPainter({required this.strokeWidth});

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final paintSaffron = Paint()
      ..color = AppColors.saffron
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final paintWhite = Paint()
      ..color = const Color(0xFFF0F4F8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final paintGreen = Paint()
      ..color = AppColors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw 3 segments of 120 degrees each (-90 deg top: Saffron on top-right, White on left/bottom, Green bottom-right)
    // Saffron: top portion (approx -2.5 to -0.6 radians)
    canvas.drawArc(rect, -2.6, 2.0, false, paintSaffron);
    // Green: bottom portion (approx 0.6 to 2.5 radians)
    canvas.drawArc(rect, 0.6, 2.0, false, paintGreen);
    // White/Navy touch: remaining arc
    canvas.drawArc(rect, 2.7, 0.9, false, paintWhite);
    canvas.drawArc(rect, -0.5, 1.0, false, paintWhite);
  }

  @override
  bool shouldRepaint(covariant _TricolorRingPainter oldDelegate) =>
      oldDelegate.strokeWidth != strokeWidth;
}

/// Saffron / White / Green band representing the Indian Tricolor / INC Tiranga flag.
class TricolorStripe extends StatelessWidget {
  const TricolorStripe({
    super.key,
    this.height = 4,
    this.borderRadius = 3,
    this.margin,
  });

  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final stripe = Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: ColoredBox(color: AppColors.saffron)),
          Expanded(child: ColoredBox(color: AppColors.white)),
          Expanded(child: ColoredBox(color: AppColors.green)),
        ],
      ),
    );

    if (margin != null) {
      return Padding(padding: margin!, child: stripe);
    }
    return stripe;
  }
}

/// Professional Neumorphic Raised or Sunken Surface.
class NeoSurface extends StatelessWidget {
  const NeoSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 18,
    this.onTap,
    this.color,
    this.isSunken = false,
    this.borderColor,
    this.border,
    this.elevation = 1.0,
    this.hasHighlightBorder = true,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final Color? color;
  final bool isSunken;
  final Color? borderColor;
  final BoxBorder? border;
  final double elevation;
  final bool hasHighlightBorder;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final surfaceColor =
        color ?? (isLight ? AppColors.surface : const Color(0xFF1D2434));

    final effectiveBorder =
        border ??
        (borderColor != null
            ? Border.all(color: borderColor!, width: 1.2)
            : (hasHighlightBorder && !isSunken && isLight
                  ? Border.all(
                      color: Colors.white.withValues(alpha: 0.85),
                      width: 1.0,
                    )
                  : null));

    final decoration = isSunken
        ? BoxDecoration(
            color: isLight ? const Color(0xFFE5EBF2) : const Color(0xFF151B27),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isLight ? const Color(0xFFCFD9E5) : Colors.black45,
              width: 1.2,
            ),
            gradient: isLight
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE2E9F0),
                      Color(0xFFEEF3F8),
                      Color(0xFFF5F8FA),
                    ],
                  )
                : null,
          )
        : BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: effectiveBorder,
            boxShadow: elevation <= 0
                ? null
                : [
                    BoxShadow(
                      color: isLight
                          ? AppColors.shadowLight
                          : const Color(0x0DFFFFFF),
                      offset: Offset(-2 * elevation, -2 * elevation),
                      blurRadius: 4 * elevation,
                    ),
                    BoxShadow(
                      color: isLight
                          ? AppColors.shadowDark
                          : const Color(0x66000000),
                      offset: Offset(2.5 * elevation, 2.5 * elevation),
                      blurRadius: 5 * elevation,
                    ),
                  ],
          );

    final content = Padding(padding: padding, child: child);

    return Semantics(
      button: onTap != null,
      child: Container(
        margin: margin,
        decoration: decoration,
        child: onTap == null
            ? content
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  splashColor: AppColors.partyBlue.withValues(alpha: 0.08),
                  highlightColor: AppColors.partyBlue.withValues(alpha: 0.04),
                  onTap: onTap,
                  child: content,
                ),
              ),
      ),
    );
  }
}

/// A neumorphic card replacing Material Cards across the app.
class NeoCard extends StatelessWidget {
  const NeoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 12),
    this.borderRadius = 18,
    this.onTap,
    this.color,
    this.borderColor,
    this.hasTricolorTop = false,
    this.isSunken = false,
    this.elevation = 1.0,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final bool hasTricolorTop;
  final bool isSunken;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    Widget cardContent = child;

    if (hasTricolorTop) {
      cardContent = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [const TricolorStripe(height: 4, borderRadius: 2), child],
      );
    }

    return RepaintBoundary(
      child: Padding(
        padding: margin,
        child: NeoSurface(
          padding: padding,
          borderRadius: borderRadius,
          onTap: onTap,
          color: color,
          borderColor: borderColor,
          isSunken: isSunken,
          elevation: elevation,
          child: cardContent,
        ),
      ),
    );
  }
}

/// Neumorphic circular or squircle icon badge.
class NeoIcon extends StatelessWidget {
  const NeoIcon(
    this.icon, {
    super.key,
    this.color,
    this.size = 44,
    this.iconSize,
    this.isSunken = false,
    this.backgroundColor,
  });

  final IconData icon;
  final Color? color;
  final double size;
  final double? iconSize;
  final bool isSunken;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;
    final radius = size / 3.2;

    return NeoSurface(
      padding: EdgeInsets.zero,
      borderRadius: radius,
      color: backgroundColor,
      isSunken: isSunken,
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          color: effectiveColor,
          size: iconSize ?? (size * 0.52),
        ),
      ),
    );
  }
}

enum NeoButtonVariant {
  primary, // INC Royal Party Blue gradient
  saffron, // Tiranga Saffron gradient
  green, // Tiranga Green gradient
  surface, // Raised Neumorphic surface with ink text
  danger, // Urgent error red
}

/// Tactile, pressable Neumorphic button with INC branding.
class NeoButton extends StatefulWidget {
  const NeoButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = NeoButtonVariant.primary,
    this.isFullWidth = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
    this.borderRadius = 16,
    this.fontSize,
    this.maxLines = 2,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final NeoButtonVariant variant;
  final bool isFullWidth;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? fontSize;
  final int maxLines;

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    final (gradient, textColor, shadowColor) = switch (widget.variant) {
      NeoButtonVariant.primary => (
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B6EB5), Color(0xFF0F4777)],
        ),
        Colors.white,
        const Color(0x40135A91),
      ),
      NeoButtonVariant.saffron => (
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFA036), Color(0xFFE65D00)],
        ),
        Colors.white,
        const Color(0x40E65D00),
      ),
      NeoButtonVariant.green => (
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF199A0A), Color(0xFF0F6805)],
        ),
        Colors.white,
        const Color(0x40138808),
      ),
      NeoButtonVariant.surface => (null, AppColors.ink, AppColors.shadowDark),
      NeoButtonVariant.danger => (
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE53935), Color(0xFFC62828)],
        ),
        Colors.white,
        const Color(0x40D32F2F),
      ),
    };

    final isLight = Theme.of(context).brightness == Brightness.light;
    final surfaceColor = widget.variant == NeoButtonVariant.surface
        ? (isLight ? AppColors.surface : const Color(0xFF222B3D))
        : null;

    final double elevation = _isPressed ? 0.3 : 1.0;

    final boxDecoration = BoxDecoration(
      color: surfaceColor,
      gradient: isEnabled ? gradient : null,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      border: Border.all(
        color: Colors.white.withValues(alpha: isLight ? 0.35 : 0.1),
        width: 1.0,
      ),
      boxShadow: !isEnabled
          ? null
          : _isPressed
          ? [
              BoxShadow(
                color: shadowColor.withValues(alpha: 0.2),
                offset: const Offset(1, 1),
                blurRadius: 3,
              ),
            ]
          : [
              BoxShadow(
                color: isLight
                    ? AppColors.shadowLight
                    : Colors.white.withValues(alpha: 0.05),
                offset: Offset(-2 * elevation, -2 * elevation),
                blurRadius: 3.5 * elevation,
              ),
              BoxShadow(
                color: shadowColor,
                offset: Offset(2 * elevation, 2.5 * elevation),
                blurRadius: 4.5 * elevation,
              ),
            ],
    );

    Widget child = Row(
      mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 16, color: textColor),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isEnabled ? textColor : Colors.grey,
              fontWeight: FontWeight.w700,
              fontSize: widget.fontSize ?? 13,
              height: 1.15,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ],
    );

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: widget.padding,
        decoration: boxDecoration,
        child: child,
      ),
    );
  }
}

/// Neumorphic pill filter chip.
class NeoFilterChip extends StatelessWidget {
  const NeoFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    this.selectedColor,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final activeColor = selectedColor ?? AppColors.partyBlue;

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onSelected != null ? () => onSelected!(!selected) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: selected
              ? BoxDecoration(
                  color: activeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: activeColor, width: 1.4),
                  boxShadow: [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.25),
                      offset: const Offset(1, 2),
                      blurRadius: 4,
                    ),
                  ],
                )
              : BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.9),
                    width: 1.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      offset: Offset(-2, -2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: AppColors.shadowDark,
                      offset: Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
              ] else if (icon != null) ...[
                Icon(icon, size: 14, color: AppColors.mutedInk),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected ? activeColor : AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Neumorphic sunken input field.
class NeoTextField extends StatelessWidget {
  const NeoTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.minLines,
    this.maxLines = 1,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              labelText!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
        NeoSurface(
          padding: EdgeInsets.zero,
          borderRadius: 16,
          isSunken: true,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            validator: validator,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            obscureText: obscureText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.mutedInk,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.partyBlue, size: 20)
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.partyBlue,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Neumorphic Status Badge (e.g. Open, In Progress, Resolved, Verified).
class NeoStatusBadge extends StatelessWidget {
  const NeoStatusBadge({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.icon,
  });

  final String label;
  final Color color;
  final Color textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            offset: const Offset(-1, -1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            offset: const Offset(1, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ] else ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Neumorphic Floating Action Button with Tiranga / INC styling.
class NeoFloatingActionButton extends StatelessWidget {
  const NeoFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.label,
    this.isSaffron = true,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? label;
  final bool isSaffron;

  @override
  Widget build(BuildContext context) {
    final gradient = isSaffron
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFA238), Color(0xFFE65D00)],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1B6EB5), Color(0xFF0F4777)],
          );

    final shadowColor = isSaffron
        ? const Color(0x55E65D00)
        : const Color(0x55135A91);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-3, -3),
            blurRadius: 6,
          ),
          BoxShadow(
            color: shadowColor,
            offset: const Offset(4, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(26),
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: label != null ? 20 : 16,
                vertical: 14,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  if (label != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      label!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Neumorphic circular or squircle icon button.
class NeoIconButton extends StatelessWidget {
  const NeoIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 42,
    this.iconSize,
    this.color,
    this.backgroundColor,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double? iconSize;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    Widget button = NeoSurface(
      padding: EdgeInsets.zero,
      borderRadius: size / 3,
      color: backgroundColor,
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: iconSize ?? (size * 0.5),
          color: color ?? AppColors.partyBlue,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
