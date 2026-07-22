import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../app_module.dart';
import '../../core/global/local_storage_utils.dart';
import '../../core/ui/theme/styles/colors_app.dart';
import '../../core/ui/theme/styles/text_styles.dart';
import '../../mock/setores.dart';
import '../../models/usuario_model.dart';
import '../../shared/data/solicitacao/dto/dashboard_resumo_model.dart';
import 'inicializar_controller.dart';

class InicializarPage extends StatefulWidget {
  const InicializarPage({super.key});

  @override
  State<InicializarPage> createState() => _InicializarPageState();
}

class _InicializarPageState extends State<InicializarPage> with SingleTickerProviderStateMixin {
  final controller = Modular.get<InicializarController>();

  late Image logo;
  List<ReactionDisposer> disposers = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _iniciarVariaveis();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colors.primary.withValues(alpha: 0.03), const Color(0xFFF8FBFF), const Color(0xFFEEF5FF)],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Elementos de fundo decorativos (Glow effect moderno)
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(shape: BoxShape.circle, color: colors.primary.withValues(alpha: 0.06)),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(shape: BoxShape.circle, color: colors.secondary.withValues(alpha: 0.05)),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(scale: _scaleAnimation.value, child: child);
                      },
                      child: Hero(tag: 'app_logo', child: logo),
                    ),

                    const SizedBox(height: 15),

                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Carregando suas informações',
                            style: context.textStyles.textMedium.copyWith(
                              color: colors.black.withValues(alpha: 0.85),
                              fontSize: 18,
                              letterSpacing: -0.4,
                            ),
                          ),
                          Text(
                            'Por favor, aguarde um instante...',
                            textAlign: TextAlign.center,
                            style: context.textStyles.textRegular.copyWith(
                              color: colors.black.withValues(alpha: 0.7),
                              fontSize: 14,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    CircularProgressIndicator(color: colors.primary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _iniciarVariaveis() async {
    logo = Image.asset('assets/images/logo.png', height: 180, width: 180, fit: .contain);
  }

  Future<void> transition() async {
    final String username = await LocalStorageUtils.getValue(SessionStorageKeys.username.key);

    if (username.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 2000));
      await navigateToLogin();
    } else {
      await Future.delayed(const Duration(milliseconds: 3000));
      final usuario = await LocalStorageUtils.getUsuario();
      final resumo = await controller.carregarResumoDashboard();
      await navigateToMain(usuario: usuario, resumo: resumo);
    }
  }

  Future<void> navigateToLogin() async {
    await Modular.to.pushReplacementNamed(Routes.login);
  }

  Future<void> navigateToMain({required UsuarioModel usuario, required DashboardResumoModel resumo}) async {
    final arguments = {'usuario': usuario, 'setores': setores, 'resumo': resumo};
    await Modular.to.pushReplacementNamed(Routes.main, arguments: arguments);
  }
}
