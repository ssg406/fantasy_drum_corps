import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_validators.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/register_screen/register_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/register_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/data/onboarding_repository.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:fantasy_drum_corps/src/utils/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final _displayNameController = TextEditingController();
  var _submitted = false;
  String? selectedCorps;

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get displayName => _displayNameController.text;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
    });
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(registerScreenControllerProvider.notifier);
      await controller.registerUser(
          email: email,
          password: password,
          displayName: displayName,
          sponsoredCorps: selectedCorps!);
      ref.read(onboardingRepositoryProvider).setOnboardingComplete();
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _displayNameEditingComplete() {
    if (canSubmitDisplayName(displayName)) {
      _node.nextFocus();
    }
  }

  void _onCorpsSelected(String? name) {
    setState(() {
      selectedCorps = name;
    });
  }

  void _passwordEditingComplete() {}
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(registerScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(registerScreenControllerProvider);
    return Scaffold(
      body: ResponsiveCenter(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 35.0),
        maxContentWidth: 600,
        child: FocusScope(
          node: _node,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoText(size: 40.0),
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
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    labelText: 'Display Name'.hardcoded,
                    hintText: 'BugleBoy99'.hardcoded,
                    enabled: !state.isLoading,
                  ),
                  validator: (displayName) => !_submitted
                      ? null
                      : getDisplayNameErrors(displayName ?? ''),
                  onEditingComplete: _displayNameEditingComplete,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
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
                DropdownButtonFormField<String>(
                  items: DrumCorpsData.allNames
                      .map<DropdownMenuItem<String>>((name) => DropdownMenuItem(
                            value: name,
                            child: Text(name),
                          ))
                      .toList(),
                  onChanged: _onCorpsSelected,
                  hint: const Text('Choose a Drum Corps to Sponsor'),
                  validator: (selection) =>
                      selection == null ? 'Please choose a corps' : null,
                ),
                gapH32,
                PrimaryButton(
                    onPressed: _submit,
                    label: 'Register',
                    isLoading: state.isLoading)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
