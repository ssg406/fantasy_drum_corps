import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_text_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/oauth_provider.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// [AuthenticateScreen] shows sign in and registration form and allows the user
/// to toggle between each function.
class AuthenticateScreen extends ConsumerStatefulWidget {
  const AuthenticateScreen({Key? key, required this.formType})
      : super(key: key);
  final AuthenticationFormType formType;

  @override
  ConsumerState<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends ConsumerState<AuthenticateScreen>
    with RegistrationValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _submitted = false;
  late var _formType = widget.formType;

  String get email => _emailController.text;

  String get password => _passwordController.text;

  @override
  void dispose() {
    _node.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _submitted = true);
    // check for validation
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(authenticateScreenControllerProvider.notifier);
      await controller.submit(
          email: email, password: password, formType: _formType);
    }
  }

  void _submitSSO(OAuthSignInProvider provider) {
    final controller = ref.read(authenticateScreenControllerProvider.notifier);
    controller.authenticateWithOAuthProvider(provider);
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType.toggledFormAction;
      _passwordController.clear();
    });
  }

  void _showResetPasswordDialog(BuildContext context) async {
    final fieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Email Address'),
          content: TextField(
            controller: fieldController,
            decoration: const InputDecoration(labelText: 'Email Address'),
          ),
          actions: [
            // Cancel
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => _sendPasswordResetEmail(fieldController.text),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _sendPasswordResetEmail(String email) async {
    final controller = ref.read(authenticateScreenControllerProvider.notifier);
    await controller.sendPasswordResetMail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(authenticateScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(authenticateScreenControllerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          padding: centerContentPadding,
          maxContentWidth: 600,
          child: FocusScope(
            node: _node,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LogoText(
                    size: 50.0,
                  ),
                  gapH32,
                  Text(
                    _formType.title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  gapH16,
                  Row(
                    children: [
                      Text(_formType.secondaryFormText),
                      PrimaryTextButton(
                          isLoading: state.isLoading,
                          onPressed: _toggleFormType,
                          label: _formType.toggleFormButtonText),
                    ],
                  ),
                  gapH16,
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email'.hardcoded,
                      hintText: 'me@gmail.com'.hardcoded,
                      enabled: !state.isLoading,
                    ),
                    validator: (email) =>
                        !_submitted ? null : getEmailErrors(email ?? ''),
                    //
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) =>
                        !_submitted ? null : getPasswordErrors(password ?? ''),
                    onEditingComplete: _passwordEditingComplete,
                  ),
                  gapH8,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () => _showResetPasswordDialog(context),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  gapH20,
                  PrimaryButton(
                      isLoading: state.isLoading,
                      onPressed: _submit,
                      label: _formType.submitButtonText.toUpperCase()),
                  gapH32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () => _submitSSO(OAuthSignInProvider.google),
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                        ),
                        label: const Text('Continue with Google'),
                      ),
                      gapW16,
                      TextButton.icon(
                        onPressed: () =>
                            _submitSSO(OAuthSignInProvider.facebook),
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        label: const Text('Continue with Facebook'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
