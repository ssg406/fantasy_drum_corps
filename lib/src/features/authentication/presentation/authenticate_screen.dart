import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/primary_text_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_screen_controller.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_validators.dart';
import 'package:fantasy_drum_corps/src/localization/string_hardcoded.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticateScreen extends ConsumerStatefulWidget {
  const AuthenticateScreen({Key? key, required this.formType})
      : super(key: key);
  final AuthenticationFormType formType;

  @override
  ConsumerState<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends ConsumerState<AuthenticateScreen>
    with AuthenticationValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late var _formType = widget.formType;
  var _submitted = false;

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

  void _submitSSO() async {
    final controller = ref.read(authenticateScreenControllerProvider.notifier);
    await controller.singleSignOn();
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
    });
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(authenticateScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(authenticateScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FANTASY DRUM CORPS',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
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
                Text(
                  _formType.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                gapH32,
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email'.hardcoded,
                    hintText: 'me@gmail.com'.hardcoded,
                    enabled: !state.isLoading,
                  ),
                  validator: (email) =>
                      !_submitted ? null : getEmailErrors(email ?? ''), //
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
                  validator: (password) => !_submitted
                      ? null
                      : getPasswordErrors(password ?? '', _formType),
                  onEditingComplete: _passwordEditingComplete,
                ),
                gapH20,
                PrimaryButton(
                    isLoading: state.isLoading,
                    onPressed: _submit,
                    label: _formType.submitButtonText),
                gapH48,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: _submitSSO,
                      icon: const FaIcon(FontAwesomeIcons.google),
                      label: Text('Continue with Google'.hardcoded),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          context.goNamed(AppRoutes.dashboard.name),
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      label: Text('Continue with Facebook'.hardcoded),
                    )
                  ],
                ),
                gapH20,
                const Divider(thickness: 1.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_formType.secondaryFormText),
                    PrimaryTextButton(
                        isLoading: state.isLoading,
                        onPressed: _toggleFormType,
                        label: _formType.toggleFormButtonText),
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
