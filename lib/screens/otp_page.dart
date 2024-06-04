import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:second_app/resources/app_colors.dart';
import 'package:second_app/screens/home_page.dart';
import 'package:second_app/service/service_info.dart';
import 'package:second_app/utils/common_loader.dart';
import 'package:second_app/widgets/common_snackbar.dart';
import '../resources/app_text.dart';
import '../resources/app_values.dart';
import '../utils/screen_utils.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OtpPage extends StatefulWidget {
  final String? phoneNumber;

  const OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final ServiceInfo serviceInfo = ServiceInfo();
  String enteredOtp = '';
  final GlobalKey<State> key = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20), // Add some space at the top
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppText.otpVerifytext,
                    style: TextStyle(
                      fontSize: AppSize.s25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    AppText.otpVerifytext2,
                    style: TextStyle(fontSize: AppSize.s15, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    fieldWidth: 40,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 10,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (pin) {},
                    onCompleted: (pin) {
                      setState(() {
                        enteredOtp = pin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: ScreenUtil.getScreenSize(context).height * 0.07,
              width: ScreenUtil.getScreenSize(context).width * 0.95,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Change the radius as needed
                    ),
                  ),
                ),
                onPressed: () async {
                  if (enteredOtp.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter the OTP'),
                      ),
                    );
                  } else {
                    // Proceed with OTP verification
                    await verifyOtp(widget.phoneNumber, enteredOtp);
                  }
                },
                child: const Text(
                  AppText.buttonText1,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> verifyOtp(String? phoneNumber, String otp) async {
    if (phoneNumber == null) return;
    LoaderDialog.showLoadingDialog(context, key);
    final response = await serviceInfo.verifyOtp(phoneNumber, otp);
    if (response != null && response.success == true) {
      ErrorSnackbar.showErrorSnackbar(
          context,
          response.message ?? 'OTP verified successfully!',
          SnackStatus.success);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            accessToken: response.data?.access,
            refreshToken: response.data?.refresh,
          ),
        ),
      );
    } else {
      // Handle OTP verification failure
      ErrorSnackbar.showErrorSnackbar(
          context,
          response?.message ?? 'Wrong Otp please try again',
          SnackStatus.failed);

      Navigator.pop(context);
    }
  }
}
