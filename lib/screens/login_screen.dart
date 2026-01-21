import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/screens/register_screen.dart';
import 'package:moj_projekat/screens/root_screen.dart';
import 'package:moj_projekat/util/validators.dart';
import 'package:moj_projekat/widgets/subtitle_text.dart';
import 'package:moj_projekat/widgets/title_text.dart';
import 'package:moj_projekat/widgets/v_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  static const path= '/login';
  const LoginScreen({
    super.key
  });
  
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
  
}

class _LoginScreenState extends State<LoginScreen> {
  final _form=GlobalKey<FormState>();
  final _email= TextEditingController();
  final _pass= TextEditingController();
  bool _obscure= true;

  void dispose(){
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> _login() async{
    final ok= _form.currentState?.validate() ?? false;
    if(!ok)
      return;
    
    await context.read<AuthProvider>().login(_email.text.trim(), _pass.text);

    if(!mounted)
      return;
    
    context.go(RootScreen.path);

  }
  
  @override
  Widget build(BuildContext context) {
    final loading =context.watch<AuthProvider>(). isLoading;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24,),
                const TitlesTextWidget(label: 'Vulkan • Online knjižara', fontSize: 22,),
                const SizedBox(height: 6,),
                const SubtitleTextWidget(label: 'Prijavi se ili nastavi kao gost', fontSize: 14,),
                const SizedBox(height: 20,),

                Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: Validators.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline)
                        ),
                      ),
                      const SizedBox(height: 12,),
                      TextFormField(
                        controller: _pass,
                        validator: Validators.password,
                        obscureText: _obscure,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Lozinka',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed:()=> setState(() => _obscure = !_obscure),
                            icon: Icon(_obscure? Icons.visibility : Icons.visibility_off)
                          )
                        ),
                      ),
                      const SizedBox(height: 16,),
                      VButton(
                        label: loading ? 'Učitavanje...' : 'Login',
                        icon: Icons.login,
                        onPressed: loading ? null : _login
                      ),
                      const SizedBox(height: 10,),
                      OutlinedButton(
                        onPressed: ()=> context.go(RootScreen.path), 
                        child: const Text('Nastavi kao gost')
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Nemaš nalog?'),
                          TextButton(
                            onPressed: ()=> context.push(RegisterScreen.path), 
                            child: const Text('Registruj se')
                          )
                        ],
                      )
                    ],
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  
}