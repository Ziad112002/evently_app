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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isObscure = true;
  late var localization = AppLocalizations.of(context)!;
  var formKey=GlobalKey<FormState>();

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
                    localization.loginTitle,
                    style: AppTextStyle.blue24semiBold,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  CustomTextField(
                    validator: (text){
                      if(text==null||text.isEmpty){
                        return "please enter your email!";
                      }
                      return null;
                    },
                    controller: emailCtrl,
                    hintText: localization.emailHint,
                    prefixIcon: Image.asset(AppAssets.mailLogo),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  CustomTextField(
                    validator: (text){
                      if(text==null||text.isEmpty){
                        return "please enter your password!";
                      }
                      return null;
                    },
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
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, AppRoutes.forgotPassword);
                    },
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),

                    child: Text(
                      localization.forgotPassword,
                      style: AppTextStyle.blue14semiBold.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.blue,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  buildLoginButton(),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        localization.noAccount,
                        style: AppTextStyle.darkGrey14Regular,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, AppRoutes.signup);
                        },
                        child: Text(
                          localization.signup,
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
                    text: localization.googleLogin,
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

  Widget buildLoginButton() {
    return CustomButton(
      text: localization.loginButton,
      onPress: () async {
        if(!formKey.currentState!.validate())return;
        try {
          showLoading(context);
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: emailCtrl.text,
                password: passwordCtrl.text,
              );
          UserDm.currentUser=await getUserFromFireStore(credential.user!.uid);
          Navigator.pop(context);
          Navigator.push(context, AppRoutes.navigation);
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          var message = "";
          if (e.code == 'user-not-found') {
            message = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            message = 'Wrong password provided for that user.';
          } else {
            message = e.message ?? AppConstants.defaultErrorMessage;
          }
          showMessage(context, message, title: "Error!", posText: "Ok");
        }
      },
    );
  }

Future<UserDm>getUserFromFireStore(String uid)async{
    var userCollection=FirebaseFirestore.instance.collection("users");
    DocumentSnapshot snapshot= await userCollection.doc(uid).get();
    Map json=snapshot.data()as Map;
    UserDm user =UserDm(id: uid, name:json["name"] , email: emailCtrl.text);
    return user;
}
}
