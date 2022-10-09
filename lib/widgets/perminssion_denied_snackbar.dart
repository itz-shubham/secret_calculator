import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void permissionDeniedSnackBar(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        content: const Text("Permission is required to add images"),
        action: SnackBarAction(
          label: "Open Setting",
          onPressed: () => openAppSettings(),
        ),
      ),
    );
