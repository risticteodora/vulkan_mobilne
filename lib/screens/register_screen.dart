import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/screens/root_screen.dart';
import 'package:moj_projekat/util/validators.dart';
import 'package:moj_projekat/widgets/title_text.dart';
import 'package:moj_projekat/widgets/v_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const path = '/register';
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _pass2 = TextEditingController();
  bool _obscure = true;

  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _pass2.dispose();
    super.dispose();
  }

  String? _repeatValidator(String? v) {
    if (v != _pass.text) return 'Lozinke se ne poklapaju';
    return null;
  }

  Future<void> _register() async {
    final ok = _form.currentState?.validate() ?? false;
    if (!ok) return;

    await context.read<AuthProvider>().register(
      _name.text.trim(),
      _email.text.trim(),
      _pass.text,
    );
    if (!mounted) return;

    context.go(RootScreen.path);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Registracija')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitlesTextWidget(
                label: 'Napravi Vulkan nalog',
                fontSize: 22,
              ),
              const SizedBox(height: 16),

              Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      validator: Validators.name,
                      decoration: const InputDecoration(
                        labelText: 'Ime i prezime',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _email,
                      validator: Validators.email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.mail_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pass,
                      validator: Validators.password,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Lozinka',
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pass2,
                      validator: _repeatValidator,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Ponovi lozinku',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    VButton(
                      label: loading ? 'Učitavanje...' : 'Kreiraj nalog',
                      icon: Icons.person_add_alt_1,
                      onPressed: loading ? null : _register,
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Nazad na login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
