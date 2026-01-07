import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voc_app/src/common/constants/gap.dart';
import 'package:voc_app/src/common/constants/sizes.dart';
import 'package:voc_app/src/common/localization/string_hardcoded.dart';
import 'package:voc_app/src/common/theme/theme.dart';
import 'package:voc_app/src/common/widgets/option_panel.dart';
import 'package:voc_app/src/common/widgets/styled_button.dart';
import 'package:voc_app/src/common/widgets/styled_text.dart';
import 'package:voc_app/src/common/widgets/styled_text_form_field.dart';
import 'package:voc_app/src/navigation/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  bool login = true;

  void change() {
    login = !login;
    disposeControl();
    initControl();
    setState(() {});
  }

  void newAccount() async {
    if (formKey.currentState case FormState state) {
      if (state.validate()) {
        change();
      }
    }
  }

  void newConnexion() async {
    context.goNamed(AppRoutes.repetitions.name);
  }

  void initControl() {
    usernameControl = TextEditingController();
    passwordControl = TextEditingController();
  }

  void disposeControl() {
    usernameControl.dispose();
    passwordControl.dispose();
  }

  @override
  void initState() {
    super.initState();
    initControl();
  }

  @override
  void dispose() {
    disposeControl();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Column(
        children: [
          expandH1,
          Form(
            key: formKey,
            child: OptionPanel(
              width: Sizes.p100,
              children: login ? signIn() : signUp(),
            ),
          ),
          expandH1,
        ],
      ),
    );
  }

  List<Widget> signUp() {
    return [
      gapH5,
      StyledHeadline('Créez un compte'.hardcoded, fontSize: Sizes.p6),
      gapH5,
      SizedBox(
        width: Sizes.p75,
        child: StyledTextFormField(
          color: AppColors.secondaryAccent,
          controller: usernameControl,
          validator: (value) {
            if (usernameControl.text.isEmpty) {
              return 'le nom d\'utilisateur ne doit pas être null'.hardcoded;
            }
            return null;
          },
          child: StyledText('Nom d\'utilisateur'.hardcoded),
        ),
      ),
      gapH5,
      SizedBox(
        width: Sizes.p75,
        child: StyledTextFormField(
          color: AppColors.secondaryAccent,
          controller: passwordControl,
          validator: (value) {
            if (passwordControl.text.length < 6) {
              return 'le mot de passe doit contenire 6 character ou plus'
                  .hardcoded;
            }
            return null;
          },
          child: StyledText('Mot de passe'.hardcoded),
        ),
      ),
      gapH5,
      StyledButton(
        onPressed: newAccount,
        width: Sizes.p25,
        child: StyledText('Créer'.hardcoded),
      ),
      gapH5,
      StyledButton(
        width: Sizes.p50,
        onPressed: change,
        child: StyledText('Me connecter'.hardcoded),
      ),
      gapH5,
    ];
  }

  List<Widget> signIn() {
    return [
      gapH5,
      StyledHeadline('Se Connecter'.hardcoded, fontSize: Sizes.p6),
      gapH5,
      SizedBox(
        width: Sizes.p75,
        child: StyledTextFormField(
          color: AppColors.secondaryAccent,
          controller: usernameControl,
          child: StyledText('Nom d\'utilisateur'.hardcoded),
        ),
      ),
      gapH5,
      SizedBox(
        width: Sizes.p75,
        child: StyledTextFormField(
          color: AppColors.secondaryAccent,
          controller: passwordControl,
          child: StyledText('Mot de passe'.hardcoded),
        ),
      ),
      gapH5,
      StyledButton(
        onPressed: newConnexion,
        width: Sizes.p25,
        child: StyledText('Connecter'.hardcoded),
      ),
      gapH5,
      StyledButton(
        width: Sizes.p50,
        onPressed: change,
        child: StyledText('Me créer un compte'.hardcoded),
      ),
      gapH5,
      StyledButton(
        width: Sizes.p50,
        onPressed: () {
          context.goNamed(AppRoutes.repetitions.name);
        },
        child: StyledText(
          'Continuer en tant qu\'invité'.hardcoded,
          fontSize: Sizes.p3,
        ),
      ),
      gapH5,
    ];
  }
}
