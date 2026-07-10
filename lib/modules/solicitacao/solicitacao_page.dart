import 'package:flutter/material.dart';

import '../../../mock/mock.dart';
import 'helpers/solicitacao_helper.dart';
import 'widget/filtro_categorias.dart';
import 'widget/item_solicitacao.dart';
import 'widget/sem_socitacao.dart';

class SolicitacaoPage extends StatefulWidget {
  final String title;
  const SolicitacaoPage({super.key, required this.title});

  @override
  State<SolicitacaoPage> createState() => _SolicitacaoPageState();
}

class _SolicitacaoPageState extends State<SolicitacaoPage> {
  String? categoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final categorias = SolicitacaoHelper.contarCategorias(documentos);
    final lista = SolicitacaoHelper.filtrarPorCategoria(documentos, categoriaSelecionada);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(widget.title.contains('Pessoal') ? Icons.person : Icons.business_center, color: cs.primary),
              const SizedBox(width: 6),
              Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
