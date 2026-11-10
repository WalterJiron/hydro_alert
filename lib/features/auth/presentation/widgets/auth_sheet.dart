import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../viewmodels/auth_viewmodel.dart';

enum AuthSheetMode { login, register }

/// Opens the sign-in/registration sheet. Returns `true` only when a real
/// reporter account is available. Browsing never depends on this sheet.
Future<bool> showAuthSheet(BuildContext context) async {
  final authenticated = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) => const AuthSheet(),
  );
  return authenticated ?? false;
}

class AuthSheet extends ConsumerStatefulWidget {
  const AuthSheet({super.key});

  @override
  ConsumerState<AuthSheet> createState() => _AuthSheetState();
}

class _AuthSheetState extends ConsumerState<AuthSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cedulaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthSheetMode _mode = AuthSheetMode.login;
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _cedulaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRegister = _mode == AuthSheetMode.register;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Cuenta de reportante', style: AppTypography.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Solo necesitas una cuenta para publicar reportes. Explorar el '
                'mapa, los sismos y la lista de reportes sigue siendo libre.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 16),
              SegmentedButton<AuthSheetMode>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(
                    value: AuthSheetMode.login,
                    label: Text('Iniciar sesión'),
                  ),
                  ButtonSegment(
                    value: AuthSheetMode.register,
                    label: Text('Crear cuenta'),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: _isSubmitting
                    ? null
                    : (selection) {
                        setState(() {
                          _mode = selection.first;
                          _errorMessage = null;
                        });
                      },
              ),
              const SizedBox(height: 18),
              if (isRegister) ...[
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  autofillHints: const [AutofillHints.name],
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo',
                    prefixIcon: Icon(LucideIcons.userRound),
                  ),
                  validator: _validateName,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cedulaController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Cédula',
                    hintText: '000-000000-0000A',
                    prefixIcon: Icon(LucideIcons.idCard),
                  ),
                  validator: _validateCedula,
                ),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(LucideIcons.mail),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                obscureText: _obscurePassword,
                autofillHints: isRegister
                    ? const [AutofillHints.newPassword]
                    : const [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(LucideIcons.lock),
                  suffixIcon: IconButton(
                    tooltip: _obscurePassword
                        ? 'Mostrar contraseña'
                        : 'Ocultar contraseña',
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    icon: Icon(
                      _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                    ),
                  ),
                ),
                validator: _validatePassword,
                onFieldSubmitted: (_) => _submit(),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 14),
                InfoBanner(
                  icon: LucideIcons.circleAlert,
                  tone: InfoBannerTone.danger,
                  message: _errorMessage!,
                ),
              ],
              const SizedBox(height: 18),
              CustomButton(
                label: isRegister ? 'Crear cuenta y continuar' : 'Entrar',
                icon: isRegister ? LucideIcons.userPlus : LucideIcons.logIn,
                expand: true,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
              const SizedBox(height: 10),
              Text(
                isRegister
                    ? 'Tu cédula se usa solo para validar la cuenta y no se '
                          'muestra en los reportes.'
                    : 'Si aún no tienes cuenta, cambia a «Crear cuenta».',
                style: AppTypography.labelSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_isSubmitting) {
      return;
    }

    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final auth = ref.read(authViewModelProvider.notifier);
    final failure = _mode == AuthSheetMode.register
        ? await auth.register(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            cedula: _cedulaController.text,
          )
        : await auth.login(
            email: _emailController.text,
            password: _passwordController.text,
          );

    if (!mounted) {
      return;
    }

    if (failure != null) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = failure.message;
      });
      return;
    }

    Navigator.of(context).pop(true);
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.length < 3) {
      return 'Escribe tu nombre completo.';
    }
    return null;
  }

  String? _validateCedula(String? value) {
    final cedula = value?.trim() ?? '';
    final pattern = RegExp(r'^\d{3}-?\d{6}-?\d{4}[A-Za-z]$');
    if (!pattern.hasMatch(cedula)) {
      return 'Usa el formato 000-000000-0000A.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!pattern.hasMatch(email)) {
      return 'Escribe un correo válido.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    if (password.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }
    return null;
  }
}
