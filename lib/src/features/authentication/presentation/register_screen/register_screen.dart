import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_text_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/shared_preferences_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_validators.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/register_screen/register_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/register_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:fantasy_drum_corps/src/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Registration screen presented after initial onboarding
class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen>
    with RegistrationValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _submitted = false;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
    });
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(registerScreenControllerProvider.notifier);
      ref.read(sharedPreferencesRepositoryProvider).setRegistrationComplete();
      await controller.addAppUser(email: email, password: password);
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _returnToSignIn() {
    ref.read(sharedPreferencesRepositoryProvider).setRegistrationComplete();
    context.goNamed(AppRoutes.signIn.name);
  }

  void _passwordEditingComplete() {
    if (email.isEmpty) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(registerScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(registerScreenControllerProvider);
    return Scaffold(
      body: ResponsiveCenter(
        padding: centerContentPadding,
        maxContentWidth: 600,
        child: FocusScope(
          node: _node,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300.0,
                  height: 300.0,
                  child: Image.asset(
                    'fc_logo_sm.png',
                    fit: BoxFit.contain,
                  ),
                ),
                gapH32,
                Text(
                  'Register'.hardcoded,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                gapH32,
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address'.hardcoded,
                    hintText: 'ex@example.com'.hardcoded,
                    enabled: !state.isLoading,
                  ),
                  validator: (email) =>
                      !_submitted ? null : getEmailErrors(email ?? ''),
                  onEditingComplete: _emailEditingComplete,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  keyboardAppearance: Brightness.light,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                gapH20,
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password'.hardcoded,
                    enabled: !state.isLoading,
                  ),
                  obscureText: true,
                  autocorrect: false,
                  keyboardAppearance: Brightness.light,
                  enableSuggestions: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      !_submitted ? null : getPasswordErrors(password ?? ''),
                  onEditingComplete: _passwordEditingComplete,
                ),
                gapH20,
                PrimaryButton(
                    onPressed: _submit,
                    label: 'Register',
                    isLoading: state.isLoading),
                gapH48,
                const Divider(thickness: 1.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already registered?'),
                    PrimaryTextButton(
                        isLoading: state.isLoading,
                        onPressed: _returnToSignIn,
                        label: 'SIGN IN'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
