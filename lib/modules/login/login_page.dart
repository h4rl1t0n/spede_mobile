import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/helpers/loader.dart';
import '../../core/helpers/messages.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  late final TextEditingController usuarioTEC;
  late final TextEditingController senhaTEC;

  final usuarioFocusNode = FocusNode();
  final senhaFocusNode = FocusNode();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    usuarioTEC = TextEditingController();
    senhaTEC = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    });
  }

  @override
  void dispose() {
    usuarioTEC.dispose();
    senhaTEC.dispose();
    usuarioFocusNode.dispose();
    senhaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teste = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Visibility(
              visible: !teste,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: .7,
                    child: Image.asset(
                      'assets/images/background.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                SizedBox(
                                  height: 280,
                                  width: double.infinity,
                                  child: Image.asset(
                                    'assets/images/predio.jpeg',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                                  ),
                                ),
                                Transform.translate(offset: const Offset(0, 10), child: _buildLogo()),
                              ],
                            ),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 430),
                                  child: Column(
                                    // Alterado para MAX para permitir o uso dos Spacers
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // Preenche espaço superior de forma dinâmica
                                      const Spacer(flex: 2),

                                      const Text(
                                        'Bem-vindo ao SPEDE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        'Sistema de Processos e Documentos\nEletrônicos',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18.0),
                                      ),

                                      const SizedBox(height: 32),
                                      _inputUsuario,

                                      const SizedBox(height: 16),
                                      _inputSenha,
                                      const SizedBox(height: 10),

                                      _buttonSaveMe,

                                      const SizedBox(height: 10),
                                      _buttonEntrar,

                                      // Empurra a Central de Ajuda lá para baixo dinamicamente
                                      const Spacer(flex: 3),

                                      // const CentralDeAjuda(),

                                      // Respiro de 90 de altura garante que o botão não bata na arte azul do rodapé
                                      const SizedBox(height: 90),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Card(
      color: Colors.transparent,
      elevation: 7,
      child: Container(
        width: 140,
        height: 140,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(12),
        child: Hero(
          tag: 'logo',
          child: Image.asset('assets/images/logo_old.png', fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget get _inputUsuario {
    return TextFormField(
      controller: usuarioTEC,
      focusNode: usuarioFocusNode,
      textInputAction: TextInputAction.next,
      validator: Validatorless.required('Informe seu usuário'),
      decoration: const InputDecoration(
        labelText: 'Usuário',
        hintText: 'Digite seu usuário',
        prefixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  Widget get _inputSenha {
    return TextFormField(
      controller: senhaTEC,
      focusNode: senhaFocusNode,
      obscureText: obscureText,
      validator: Validatorless.required('Informe sua senha'),
      decoration: InputDecoration(
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              key: ValueKey(obscureText),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buttonEntrar {
    return SizedBox(
      height: 50,
      child: FilledButton(
        onPressed: () async {
          showLoader();
          await Future.delayed(Duration(seconds: 1));
          hideLoader();

          await toHomePage();
        },
        child: const Text('Entrar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget get _buttonSaveMe {
    return CheckboxListTile(
      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(4)),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text('Lembrar-me', style: TextStyle(fontSize: 14)),
      value: true,
      onChanged: (value) {},
    );
  }

  Future<void> toHomePage() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage(title: 'Pessoal > Solicitações Recebidas')),
    );
  }
}
