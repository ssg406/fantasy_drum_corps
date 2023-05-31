import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/authentication/oauth_provider.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/register_screen_validators.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

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
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(authenticateScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(authenticateScreenControllerProvider);
    final breakpoints = ResponsiveBreakpoints.of(context);
    final theme = Theme.of(context);
    final textSize = breakpoints.largerThan(TABLET) ? 40.0 : 30.0;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          padding:
              breakpoints.largerThan(MOBILE) ? pagePadding : mobilePagePadding,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (breakpoints.largerThan(TABLET))
                  IntroText(textSize: textSize),
                Expanded(
                  child: Container(
                    margin: breakpoints.largerThan(TABLET)
                        ? const EdgeInsets.only(left: Sizes.p48)
                        : null,
                    child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: FocusScope(
                        node: _node,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: breakpoints.largerThan(TABLET)
                                ? cardPadding
                                : mobileCardPadding,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (breakpoints.smallerOrEqualTo(TABLET)) ...[
                                  LogoText(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: textSize,
                                    alignment: MainAxisAlignment.center,
                                  ),
                                  gapH32,
                                ],
                                Text(
                                  _formType.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: theme.colorScheme.onPrimary),
                                ),
                                gapH16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _formType.secondaryFormText,
                                      style: TextStyle(
                                          color: theme.colorScheme.onPrimary),
                                    ),
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                          foregroundColor:
                                              theme.colorScheme.onPrimary),
                                      icon: const Icon(
                                          Icons.app_registration_rounded),
                                      onPressed: _toggleFormType,
                                      label:
                                          Text(_formType.toggleFormButtonText),
                                    ),
                                  ],
                                ),
                                gapH16,
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Email',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    enabled: !state.isLoading,
                                  ),
                                  validator: (email) => !_submitted
                                      ? null
                                      : getEmailErrors(email ?? ''),
                                  //
                                  onEditingComplete: _emailEditingComplete,
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  keyboardAppearance: Brightness.light,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                gapH20,
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      enabled: !state.isLoading,
                                      label: const Text('Password'),
                                      hintText: 'Password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never),
                                  obscureText: true,
                                  autocorrect: false,
                                  keyboardAppearance: Brightness.light,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (password) => !_submitted
                                      ? null
                                      : getPasswordErrors(password ?? ''),
                                  onEditingComplete: _passwordEditingComplete,
                                ),
                                gapH8,
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () =>
                                        _showResetPasswordDialog(context),
                                    child: Text(
                                      'Forgot Password?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: theme
                                                  .colorScheme.inversePrimary),
                                    ),
                                  ),
                                ),
                                gapH12,
                                FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                      backgroundColor:
                                          theme.colorScheme.onPrimary,
                                      foregroundColor:
                                          theme.colorScheme.primary),
                                  icon: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                  onPressed: _submit,
                                  label: state.isLoading
                                      ? CircularProgressIndicator(
                                          color: theme.colorScheme.onPrimary,
                                        )
                                      : Text(_formType.submitButtonText),
                                ),
                                gapH32,
                                Flex(
                                  direction: breakpoints.smallerThan(TABLET)
                                      ? Axis.horizontal
                                      : Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                          foregroundColor:
                                              theme.colorScheme.onPrimary),
                                      onPressed: () => _submitSSO(
                                          OAuthSignInProvider.google),
                                      icon: const FaIcon(
                                        FontAwesomeIcons.google,
                                      ),
                                      label: const Text('Continue with Google'),
                                    ),
                                    gapW16,
                                    if (kIsWeb)
                                      TextButton.icon(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                theme.colorScheme.onPrimary),
                                        onPressed: () => _submitSSO(
                                            OAuthSignInProvider.facebook),
                                        icon: const FaIcon(
                                            FontAwesomeIcons.facebook),
                                        label: const Text(
                                            'Continue with Facebook'),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
}

class IntroText extends StatelessWidget {
  const IntroText({Key? key, required this.textSize}) : super(key: key);
  final double textSize;

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoText(
          size: textSize,
        ),
        gapH16,
        SizedBox(
          width: breakpoints.screenWidth * 0.3,
          child: const Text(
            'Ut enim ad minim veniam, quis nostrud exercitation '
            'ullamco laboris nisi ut aliquip ex ea commodo '
            'consequat. Duis aute irure dolor in reprehenderit '
            'in voluptate velit esse cillum dolore eu fugiat '
            'nulla pariatur. Excepteur sint occaecat cupidatat '
            'non proident, sunt in culpa qui officia deserunt '
            'mollit anim id est laborum.',
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
