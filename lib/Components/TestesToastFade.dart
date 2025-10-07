//DEIXAR GUARDADO.
import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

void showToastTeste(
    BuildContext context,
    String message, {
      ToastType type = ToastType.info,
      Duration duration = const Duration(seconds: 3),
    }) {
  IconData icon;
  Color color;
  String title;

  switch (type) {
    case ToastType.success:
      icon = Icons.check_circle_rounded;
      color = Colors.green.shade600;
      title = "Sucesso";
      break;
    case ToastType.error:
      icon = Icons.error_rounded;
      color = Colors.red.shade600;
      title = "Erro";
      break;
    case ToastType.warning:
      icon = Icons.warning_rounded;
      color = Colors.orange.shade700;
      title = "Atenção";
      break;
    case ToastType.info:
    default:
      icon = Icons.info_rounded;
      color = Colors.blue.shade700;
      title = "Informação";
  }

  final overlay = Overlay.of(context);
  if (overlay == null) return;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50,
      left: MediaQuery.of(context).size.width * 0.5 - 160,
      child: _ToastWidget(
        icon: icon,
        color: color,
        title: title,
        message: message,
        duration: duration,
        onDismiss: () => overlayEntry.remove(),
      ),
    ),
  );

  overlay.insert(overlayEntry);
}

class _ToastWidget extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final Duration duration;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Fade in
    Future.delayed(Duration.zero, () {
      if (mounted) setState(() => opacity = 1.0);
    });

    // Fade out após duração
    Future.delayed(widget.duration, () {
      if (!mounted) return;

      setState(() => opacity = 0.0);

      // Remove depois do fade out
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) widget.onDismiss();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 320,
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: widget.color, size: 32),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BlackBrothers')),
                  Text(widget.message,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'BlackBrothers')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
