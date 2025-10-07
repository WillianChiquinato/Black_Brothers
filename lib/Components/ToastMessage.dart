import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

enum ToastType { success, error, warning, info }

void showToast(BuildContext context, String message,
    {ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3)}) {
  // Configurações por tipo
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

  // Cria o toast
  MotionToast(
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontFamily: 'BlackBrothers', fontWeight: FontWeight.bold),
    ),
    description: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'BlackBrothers'),
    ),
    icon: icon,
    primaryColor: color,
    secondaryColor: Colors.black54,
    width: 320,
    height: 65,
    borderRadius: 7,
    displayBorder: false,
    animationType: AnimationType.slideInFromBottom,
    animationCurve: Curves.easeIn,
    toastDuration: duration,
    toastAlignment: Alignment.bottomCenter,
  ).show(context);
}
