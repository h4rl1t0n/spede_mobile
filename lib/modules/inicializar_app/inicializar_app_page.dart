import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/global/local_storage_utils.dart';
import '../../core/ui/theme/styles/colors_app.dart';
import '../../core/ui/theme/styles/text_styles.dart';
import '../../models/usuario_model.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';

class InicializarAppPage extends StatefulWidget {
  const InicializarAppPage({super.key});

  @override
  State<InicializarAppPage> createState() => _InicializarAppPageState();
}

class _InicializarAppPageState extends State<InicializarAppPage> with SingleTickerProviderStateMixin {
  late Image logo;
  List<ReactionDisposer> disposers = [];

  // Controladores de animação
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _iniciarVariaveis();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await transition();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var dispose in disposers) {
      dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    precacheImage(logo.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFF5FAFF), Color(0xFFEAF4FF)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: <Widget>[
              Hero(
                tag: 'app_logo',
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.08),
                        blurRadius: 30,
                        spreadRadius: 10,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: logo,
                ),
              ),
              Column(
                spacing: 24,
                children: [
                  Text(
                    'Carregando suas informações.\nPor favor, aguarde...',
                    textAlign: TextAlign.center,
                    style: context.textStyles.textRegular.copyWith(
                      color: colors.black,
                      fontSize: 16,
                      height: 1.4,
                      letterSpacing: -0.3,
                    ),
                  ),

                  SizedBox(
                    width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        minHeight: 4,
                        color: colors.secondary,
                        backgroundColor: colors.primary.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _iniciarVariaveis() async {
    logo = Image.asset('assets/images/logo.png', height: 150, width: 150);
  }

  Future<void> transition() async {
    final String username = await LocalStorageUtils.getValue(SessionStorageKeys.username.key);

    if (username.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 2000));
      await navigateToLogin();
    } else {
      await Future.delayed(const Duration(milliseconds: 3000));
      final usuario = await LocalStorageUtils.getUsuario();
      await navigateToHome(usuario: usuario);
    }

    if (mounted) {
      final navigator = Navigator.of(context);
      await navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
    }
  }

  Future<void> navigateToLogin() async {
    final navigator = Navigator.of(context);
    await navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
  }

  Future<void> navigateToHome({required UsuarioModel usuario}) async {
    final navigator = Navigator.of(context);
    await navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage(usuario: usuario)),
      (route) => false,
    );
  }
}
