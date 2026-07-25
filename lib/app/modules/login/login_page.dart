import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/constants/images.dart';
import '../../core/constants/routes.dart';
import '../../core/helpers/loader.dart';
import '../../core/helpers/messages.dart';
import '../../enum/page_status.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages {
  late final LoginController controller;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController loginUsuarioTEC;
  late final TextEditingController senhaUsuarioTEC;

  List<ReactionDisposer> disposers = [];

  @override
  void initState() {
    super.initState();

    controller = inject<LoginController>();
    formKey = GlobalKey<FormState>();
    loginUsuarioTEC = TextEditingController();
    senhaUsuarioTEC = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setupReactions();
      controller.initLogin();
    });
  }

  @override
  void dispose() {
    loginUsuarioTEC.dispose();
    senhaUsuarioTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Opacity(
                  opacity: .7,
                  child: Image.asset(Images.background, height: 200, width: double.infinity, fit: BoxFit.fill),
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
                                Transform.translate(
                                  offset: const Offset(0, 10),
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 7,
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                      padding: const EdgeInsets.all(12),
                                      child: Hero(
                                        tag: 'logo',
                                        child: Image.asset(Images.logo, fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 430),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
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

                                        TextFormField(
                                          controller: loginUsuarioTEC,
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) => controller.setAuth(login: value),
                                          validator: Validatorless.required('Informe seu usuário'),
                                          decoration: const InputDecoration(
                                            labelText: 'Usuário',
                                            hintText: 'Digite seu usuário',
                                            prefixIcon: Icon(Icons.person_outline),
                                          ),
                                        ),

                                        const SizedBox(height: 16),

                                        Observer(
                                          builder: (context) {
                                            final obscureText = controller.obscureText;
                                            return TextFormField(
                                              controller: senhaUsuarioTEC,
                                              obscureText: obscureText,
                                              validator: Validatorless.required('Informe sua senha'),
                                              onChanged: (value) => controller.setAuth(senha: value),
                                              decoration: InputDecoration(
                                                labelText: 'Senha',
                                                hintText: 'Digite sua senha',
                                                prefixIcon: const Icon(Icons.lock_outline),
                                                suffixIcon: IconButton(
                                                  onPressed: controller.changeObscureText,
                                                  icon: Icon(
                                                    obscureText
                                                        ? Icons.visibility_outlined
                                                        : Icons.visibility_off_outlined,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        const SizedBox(height: 10),

                                        Observer(
                                          builder: (context) {
                                            if (controller.showManterDados) {
                                              return CheckboxListTile(
                                                contentPadding: EdgeInsets.zero,
                                                controlAffinity: ListTileControlAffinity.leading,
                                                title: const Text('Lembrar-me', style: TextStyle(fontSize: 14)),
                                                value: controller.saveData,
                                                onChanged: (value) => controller.setSaveData(value ?? false),
                                              );
                                            }

                                            return const SizedBox.shrink();
                                          },
                                        ),

                                        const SizedBox(height: 10),

                                        SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: fazerLogin,
                                            child: AnimatedSwitcher(
                                              duration: const Duration(milliseconds: 250),
                                              child: Observer(
                                                builder: (context) {
                                                  final isLoading = controller.status == PageStatus.loading;

                                                  if (isLoading) {
                                                    return const SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 3,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  }

                                                  return const Text(
                                                    'Entrar',
                                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        const Spacer(flex: 3),

                                        const SizedBox(height: 90),
                                      ],
                                    ),
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

  Future<void> fazerLogin() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    final success = await controller.login();

    if (success && mounted) {
      context.navigate(Routes.inicializar);
    }
  }

  void _setupReactions() {
    disposers = [
      reaction((_) => controller.status, (status) {
        switch (status) {
          case PageStatus.initial:
            break;
          case PageStatus.loading:
            hideLoader();
            break;
          case PageStatus.loaded:
            hideLoader();
            break;
          case PageStatus.success:
            hideLoader();
            break;
          case PageStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro, tente novamente');
            break;
        }
      }),
      reaction((_) => controller.existeDados, (existDadosLogin) {
        if (existDadosLogin) {
          loginUsuarioTEC.text = controller.auth.login;
          senhaUsuarioTEC.text = controller.auth.senha;
        }
      }),
    ];
  }
}
