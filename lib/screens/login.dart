import 'package:flutter/material.dart';
import 'package:second_app/resources/app_colors.dart';
import 'package:second_app/screens/otp_page.dart';
import 'package:second_app/service/service_info.dart';
import 'package:second_app/utils/common_loader.dart';
import 'package:second_app/utils/form_validators.dart';
import 'package:second_app/widgets/common_snackbar.dart';
import 'package:second_app/widgets/custom_alert_dialog.dart';
import '../resources/app_text.dart';
import '../resources/app_values.dart';
import '../utils/screen_utils.dart';
import '../widgets/common_textfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController phoneNumberController = TextEditingController();
  bool obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ServiceInfo serviceInfo = ServiceInfo();
  final GlobalKey<State> key = GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.appBartext,
          style: TextStyle(fontSize: AppSize.s20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        AppText.wellcomeText1,
                        style: TextStyle(
                            fontSize: AppSize.s20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        AppText.wellcomeText2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppSize.s15, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: phoneNumberController,
                        hintText: AppText.hintText1,
                        labelText: AppText.labelText1,
                        SuffixIcon: const Icon(
                          Icons.phone_android,
                        ),
                        obscureText: false,
                        validator: FormValidators.mobileNumberValidator,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: ScreenUtil.getScreenSize(context).height * 0.07,
                        width: ScreenUtil.getScreenSize(context).width * 0.95,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              checkApiStatus();
                            }
                          },
                          child: const Text(
                            AppText.buttonText1,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkApiStatus() async {
    LoaderDialog.showLoadingDialog(context, key);
    FocusScope.of(context).unfocus();

    final phoneNumber = phoneNumberController.text;
    final response = await serviceInfo.loginUser(phoneNumber);

    if (response != null && response.success!) {
      Navigator.pop(context);
      final otp = response.data?.otp;
      showCustomOtpDialog(context, otp ?? '', phoneNumber);
    } else {
      ErrorSnackbar.showErrorSnackbar(
          context, 'Failed to login. Please try again.', SnackStatus.failed);
    }
  }

  void showCustomOtpDialog(
      BuildContext context, String otp, String phoneNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          otp: otp,
          phoneNumber: phoneNumber,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onProceed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(phoneNumber: phoneNumber),
              ),
            );
          },
        );
      },
    );
  }
}
