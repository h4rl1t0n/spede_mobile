import 'package:flutter/material.dart';

import '../../mock/documentos.dart';
import '../home/home_controller.dart';
import 'helpers/solicitacao_helper.dart';
import 'widget/filtro_categorias.dart';
import 'widget/item_solicitacao.dart';
import 'widget/sem_socitacao.dart';

class SolicitacaoPage extends StatefulWidget {
  final String title;
  final HomeController controller;
  const SolicitacaoPage({super.key, required this.title, required this.controller});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends State<SolicitacaoPage> {
  String get title => widget.title;
  String? categoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final setor = widget.controller.setorSelecionado;
    final documentosFiltrados = setor == null
        ? documentos
        : documentos.where((doc) => doc.setorModel.id == setor.id).toList();

    final categorias = SolicitacaoHelper.contarCategorias(documentosFiltrados);
    final lista = SolicitacaoHelper.filtrarPorCategoria(documentosFiltrados, categoriaSelecionada);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            spacing: 5,
            children: [
              Icon(title.contains('Pessoal') ? Icons.person : Icons.business_center, color: cs.primary),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FiltroCategorias(
            categorias: categorias,
            selecionada: categoriaSelecionada,
            onSelecionada: (categoria) {
              setState(() {
                categoriaSelecionada = categoria;
              });
            },
          ),
        ),

        const Divider(height: 1),

        Expanded(
          child: Builder(
            builder: (context) {
              if (lista.isEmpty) {
                return const SemSocitacao();
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12).copyWith(bottom: 20),
                itemCount: lista.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final item = lista[index];
                  return ItemSolicitacao(solicitacao: item);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
