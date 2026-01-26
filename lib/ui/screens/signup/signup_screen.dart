import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/models/user_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:evently/ui/utils/app_dialogs.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isObscure = true;
  bool isObscure2 = true;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  late var localization = AppLocalizations.of(context)!;
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAssets.evtLogo),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  Text(
                    localization.createYourAccount,
                    style: AppTextStyle.blue24semiBold,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  CustomTextField(
                    validator: (text){
                      if(text==null||text.isEmpty){
                        return "Field is required";
                      }
                      return null;
                    },
                    controller: nameCtrl,
                    hintText: localization.enterYourName,
                    prefixIcon: Image.asset(AppAssets.personLogo),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextField(
                    validator: validateEmail,
                    controller: emailCtrl,
                    hintText: localization.emailHint,
                    prefixIcon: Image.asset(AppAssets.mailLogo),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextField(
                    validator: validatePassword,
                    controller: passwordCtrl,
                    hintText: localization.passwordHint,
                    isObscure: isObscure,
                    prefixIcon: Image.asset(AppAssets.lockLogo),
                    suffixIcon: InkWell(
                      onTap: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      child: isObscure
                          ? Icon(
                              Icons.remove_red_eye_outlined,
                              color: AppColors.grey,
                            )
                          : Image.asset(AppAssets.eyeLogo),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextField(
                    validator: (text){
                      if(text!=passwordCtrl.text){
                        return "Password doesn't match";
                      }
                      return null;
                    },
                    hintText: localization.confirmYourPassword,
                    isObscure: isObscure2,
                    prefixIcon: Image.asset(AppAssets.lockLogo),
                    suffixIcon: InkWell(
                      onTap: () {
                        isObscure2 = !isObscure2;
                        setState(() {});
                      },
                      child: isObscure2
                          ? Icon(
                              Icons.remove_red_eye_outlined,
                              color: AppColors.grey,
                            )
                          : Image.asset(AppAssets.eyeLogo),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  buildSignupButton(),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        localization.alreadyHaveAccount,
                        style: AppTextStyle.darkGrey14Regular,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          localization.login,
                          style: AppTextStyle.blue14semiBold.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  Text(
                    localization.orText,
                    style: AppTextStyle.blue16Medium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  CustomButton(
                    background: AppColors.white,
                    text: localization.signUpWithGoogle,
                    style: AppTextStyle.blue16Medium,
                    icon: Image.asset(
                      AppAssets.googleLogo,
                      height: 24,
                      width: 24,
                    ),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomButton buildSignupButton() {
    return CustomButton(
      text: localization.signup,
      onPress: () async {
        if(!formKey.currentState!.validate())return;
        try {
          showLoading(context);
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: emailCtrl.text,
                password: passwordCtrl.text,
              );
          UserDm.currentUser=UserDm(id: credential.user!.uid, name: nameCtrl.text, email: emailCtrl.text);
          createUserInFirestore(UserDm.currentUser!);

          Navigator.pop(context);
          Navigator.push(context, AppRoutes.navigation);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          var message = "";
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            message = 'The account already exists for that email.';
          } else {
            message = e.message ?? AppConstants.defaultErrorMessage;
          }
          showMessage(context, message, title: "Error!", posText: "Ok");
        } catch (e) {
          showMessage(
            context,
            AppConstants.defaultErrorMessage,
            title: "Error!",
            posText: "Ok",
          );
        }
      },
    );
  }

  Future<void> createUserInFirestore(UserDm user) async {
    var userCollection = FirebaseFirestore.instance.collection("users");
    var document = userCollection.doc(user.id);
    document.set({
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "favorites": user.favoriteEvents,
    });
  }
  String? validateEmail(String? value) {
     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
     if (value == null || value.isEmpty) {
       return 'Please enter your email';
     } else if (!emailRegex.hasMatch(value)) {
       return 'Please enter a valid email';
     }
     return null; // indicates no error
   }
  String? validatePassword(String? value) {
     if (value == null || value.length < 6) {
       return 'Password must be at least 6 characters';
     }
     return null;
   }
}
