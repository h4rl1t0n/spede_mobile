// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// import '../../../../core/ui/widgets/container_card.dart';
// import '../../../../core/ui/widgets/highlighted_item_tile.dart';
// import '../../../../core/ui/widgets/item_tile.dart';
// import '../../../../shared/data/comunicacao/datasource/comunicacao_datasource_impl.dart';
// import '../../../../shared/domain/comunicacao/entity/comunicacao_entity.dart';
// import '../../comunicacao_controller.dart';
// import '../../pages/status_comunicacao/status_comunicacao_controller.dart';
// import '../other_actions_bottom_sheet/other_actions_bottom_sheet.dart';
// import 'item_marcadores.dart';

// class ComunicacaoCard extends StatefulWidget {
//   final StatusComunicacaoController controllerStatusComunicacao;
//   final ComunicacaoTypeList statusComunicacao;
//   final ComunicacaoEntity comunicacao;

//   const ComunicacaoCard({
//     required this.comunicacao,
//     required this.controllerStatusComunicacao,
//     super.key,
//     required this.statusComunicacao,
//   });

//   @override
//   State<ComunicacaoCard> createState() => _ComunicacaoCardState();
// }

// class _ComunicacaoCardState extends State<ComunicacaoCard> {
//   final controller = Modular.get<ComunicacaoController>();

//   StatusComunicacaoController get controllerStatusComunicacao => widget.controllerStatusComunicacao;
//   ComunicacaoEntity get comunicacao => widget.comunicacao;
//   ComunicacaoTypeList get statusComunicacao => widget.statusComunicacao;

//   bool get expirado => comunicacao.prazoExpirado?.toLowerCase().contains('expirado') ?? false;

//   @override
//   Widget build(BuildContext context) {
//     return ContainerCard(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         child: Observer(
//           builder: (context) {
//             final search = controllerStatusComunicacao.searchQuery;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     if (comunicacao.statusComunicacao != ComunicacaoTypeList.pendenteCiencia.name)
//                       Expanded(
//                         child: ItemTile(
//                           title:
//                               'Marcadores ${comunicacao.marcadores.isEmpty ? '' : '(${comunicacao.marcadores.length})'}',
//                           subTitleWidget: ItemMarcadores(marcadores: comunicacao.marcadores),
//                         ),
//                       ),
//                     Expanded(
//                       child: HighlightedItemTile(
//                         search: search,
//                         title: 'Comunicação',
//                         text: comunicacao.numeroComunicacao ?? '-',
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: HighlightedItemTile(
//                         search: search,
//                         title: 'Nº do processo',
//                         text: comunicacao.numeroProcesso ?? '-',
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: HighlightedItemTile(search: search, title: 'Notificado', text: comunicacao.nomeNotificado),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: HighlightedItemTile(
//                         search: search,
//                         title: 'Data da comunicação',
//                         text: comunicacao.dataComunicacao ?? '-',
//                       ),
//                     ),
//                     Expanded(
//                       child: HighlightedItemTile(
//                         search: search,
//                         title: 'Data da ciência',
//                         text: comunicacao.dataRecebimento ?? '-',
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: HighlightedItemTile(
//                         colorSubTitleText: (comunicacao.prazo ?? '-').contains('Expirado') ? Colors.red : null,
//                         search: search,
//                         title: 'Prazo resposta/defesa',
//                         text: comunicacao.prazo ?? '-',
//                       ),
//                     ),
//                   ],
//                 ),

//                 // if (comunicacao.dataProrrogacao != null)
//                 //   Row(
//                 //     children: [
//                 //       Expanded(
//                 //         child: HighlightedItemTile(
//                 //           search: search,
//                 //           title: 'Pedido de prorrogação',
//                 //           text: pedidoProrrogacao,
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 if (comunicacao.dataDefesa != null)
//                   Row(
//                     children: [
//                       Expanded(
//                         child: HighlightedItemTile(search: search, title: 'Resposta/Defesa', text: respostaDefesa),
//                       ),
//                     ],
//                   ),

//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: showOtherActions,
//                       child: const Text('Outras ações', style: TextStyle(fontSize: 16)),
//                     ),
//                     const SizedBox(width: 10),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // String get pedidoProrrogacao => _formatarComunicacao(comunicacao.dataProrrogacao, comunicacao.situacaoProrrogacao);

//   String get respostaDefesa => _formatarComunicacao(comunicacao.dataDefesa, comunicacao.situacaoDefesa);

//   String _formatarComunicacao(String? data, String? situacao) {
//     final dataStr = data ?? '';

//     if (situacao != null && situacao.isNotEmpty) {
//       return '$dataStr ($situacao)'.trim();
//     }

//     return dataStr;
//   }

//   Future<void> showOtherActions() async {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         log(comunicacao.idComunicacao.toString());
//         return OtherActionsBottomSheet(
//           comunicacaoTypeList: statusComunicacao,
//           comunicacao: comunicacao,
//           controller: controller,
//           controllerStatusComunicacao: controllerStatusComunicacao,
//         );
//       },
//     );
//   }
// }
