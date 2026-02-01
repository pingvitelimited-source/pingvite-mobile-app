import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/auth/otp_screen/presentation/bloc/otp_bloc/otp_bloc.dart';
import 'package:pingvite/features/auth/otp_screen/presentation/widgets/otp_header.dart';
import 'package:pingvite/features/auth/otp_screen/presentation/widgets/otp_input_text.dart';
import 'package:pingvite/features/auth/otp_screen/presentation/widgets/resent_text.dart';
import 'package:pingvite/features/auth/otp_screen/presentation/widgets/verify_button.dart';
import 'package:pingvite/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class OtpScreen extends StatefulWidget {
  final Map<String, dynamic> signupData;

  const OtpScreen({super.key, required this.signupData});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();

  @override
  void initState() {
    final email = (widget.signupData[Constants.emailField] as String?) ?? '';

    context.read<SendOtpBloc>().add(SendOtpRequested(email: email));
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    final otp = _otpController.text.trim();

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AppTexts(text: 'Enter valid 4 digit OTP'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    final email = (widget.signupData[Constants.emailField] as String?) ?? '';

    context.read<SendOtpBloc>().add(
      VerifyOtpRequested(otpType: 'register', otp: otp, email: email),
    );
  }

  void _resendOtp() {
    final email = (widget.signupData[Constants.emailField] as String?) ?? '';

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AppTexts(text: 'Email is required to resend OTP'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    context.read<SendOtpBloc>().add(SendOtpRequested(email: email));
  }

  @override
  Widget build(BuildContext context) {
    final email = (widget.signupData[Constants.emailField] as String?) ?? '';

    return BlocConsumer<SendOtpBloc, OtpState>(
      listener: (context, state) {
        if (state is SendOtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTexts(text: state.data.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is SendOtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTexts(text: state.message),
              backgroundColor: AppColors.red,
            ),
          );
        } else if (state is VerifyOtpSuccess) {
          context.read<SignupBloc>().add(
            SignupSubmitted(
              firstName: (widget.signupData[Constants.firstName] as String)
                  .trim(),
              middleName: (widget.signupData[Constants.middleName] as String?)
                  ?.trim(),
              lastName: (widget.signupData[Constants.lastName] as String)
                  .trim(),
              email: (widget.signupData[Constants.emailField] as String).trim(),
              mobile: (widget.signupData[Constants.phoneField] as String)
                  .trim(),
              password: (widget.signupData[Constants.passwordField] as String)
                  .trim(),
            ),
          );
        } else if (state is VerifyOtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTexts(text: state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isVerifying = state is VerifyOtpLoading;

        return Scaffold(
          appBar: CustomAppBar.withBackButton(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.rpx),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(30.rpx),

                  OtpHeader(email: email),

                  Gap(30.rpx),

                  OtpInputText(controller: _otpController),

                  Gap(30.rpx),

                  ResendText(onTap: _resendOtp),

                  Gap(40.rpx),

                  VerifyButton(
                    onPressed: isVerifying ? () {} : _verifyOtp,
                    isLoading: isVerifying,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
