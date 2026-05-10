import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';
import 'package:hydrogrow/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = true;

  void _toggleMode() => setState(() => _isLogin = !_isLogin);

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // ── Mascotte ──────────────────────────────────────────────────
              _PlantMascot(isLogin: _isLogin),
              const SizedBox(height: 20),
              // ── Titre + tagline ───────────────────────────────────────────
              Text(
                translate.app_name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  translate.login_tagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // ── Formulaire ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: LoginForm(
                  isLogin: _isLogin,
                  onToggle: _toggleMode,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Mascotte flottante ─────────────────────────────────────────────────────────

class _PlantMascot extends StatefulWidget {
  const _PlantMascot({required this.isLogin});
  final bool isLogin;

  @override
  State<_PlantMascot> createState() => _PlantMascotState();
}

class _PlantMascotState extends State<_PlantMascot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _offset = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _float, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bubbleText = widget.isLogin ? 'Bonjour ! 👋' : 'Bienvenue ! 🌱';

    return AnimatedBuilder(
      animation: _offset,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _offset.value),
        child: child,
      ),
      child: Column(
        children: [
          // Bulle de dialogue
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _SpeechBubble(
              key: ValueKey(bubbleText),
              text: bubbleText,
              colors: colors,
            ),
          ),
          const SizedBox(height: 8),
          // Corps mascotte
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colors.menu.withValues(alpha: 0.25),
                  colors.menu.withValues(alpha: 0.08),
                ],
              ),
              border: Border.all(
                color: colors.menu.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: child,
                ),
                child: Text(
                  widget.isLogin ? '🌱' : '🌿',
                  key: ValueKey(widget.isLogin),
                  style: const TextStyle(fontSize: 54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeechBubble extends StatelessWidget {
  const _SpeechBubble({
    super.key,
    required this.text,
    required this.colors,
  });

  final String text;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: colors.menu.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ),
        // Flèche bulle
        CustomPaint(
          size: const Size(14, 7),
          painter: _BubbleTailPainter(color: colors.surface),
        ),
      ],
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  const _BubbleTailPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubbleTailPainter old) => old.color != color;
}
