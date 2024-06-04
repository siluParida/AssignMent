import 'package:flutter/material.dart';
import 'package:second_app/resources/app_colors.dart';
import 'package:second_app/resources/app_values.dart';

class CustomAlertDialog extends StatelessWidget {
  final String otp;
  final String phoneNumber;
  final VoidCallback onCancel;
  final VoidCallback onProceed;

  const CustomAlertDialog({
    Key? key,
    required this.otp,
    required this.phoneNumber,
    required this.onCancel,
    required this.onProceed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock, color: AppColors.primaryColor, size: 100),
          const SizedBox(height: 20),
          Text('Your OTP is: $otp',
              style: const TextStyle(fontSize: AppSize.s20)),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel',
              style: TextStyle(
                  color: AppColors.lightRed,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSize.s15)),
          onPressed: onCancel,
        ),
        TextButton(
          child: const Text('Proceed',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSize.s15)),
          onPressed: onProceed,
        ),
      ],
    );
  }
}
