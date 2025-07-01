import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';

class CustomSnackbar {
  static void showSnackBarSuccess(
    BuildContext context, {
    required String title,
    required String message,
    required int type,
    required int time,
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top +
            10, // Asegura que no tape la barra de estado
        left: 16,
        right: 16,
        child: FadeInDown(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: type == 1
                    ? AppColors.validationMissing
                    : type == 2
                        ? AppColors.validationJustified
                        : AppColors.validationTimely,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Ocultar el snackbar después de 2 segundos
    Future.delayed(Duration(seconds: time), () {
      overlayEntry.remove();
    });
  }
}
