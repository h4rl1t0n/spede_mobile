import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../extensions/string_extension.dart';
import '../../../global/filtro_controller.dart';
import '../../theme/styles/text_styles.dart';

class CustomDropdownSearch<T> extends StatefulWidget {
  final FiltroController? controller;
  final List<T> items;
  final bool enabled;
  final String Function(T) itemAsString;
  final T? selectedItem;
  final VoidCallback? onClear;
  final String label;
  final String title;
  final String? Function(T?)? validator;
  final void Function(T?) onSelected;
  final void Function(T?)? onSaved;

  const CustomDropdownSearch({
    super.key,
    this.onClear,
    this.validator,
    this.controller,
    this.enabled = true,
    required this.items,
    required this.itemAsString,
    required this.selectedItem,
    required this.label,
    required this.title,
    required this.onSelected,
    this.onSaved,
  });

  @override
  State<CustomDropdownSearch<T>> createState() => _CustomDropdownSearchState<T>();
}

class _CustomDropdownSearchState<T> extends State<CustomDropdownSearch<T>> {
  FiltroController? get controller => widget.controller;
  List<T> get items => widget.items;
  String Function(T) get itemAsString => widget.itemAsString;
  T? get selectedItem => widget.selectedItem;
  VoidCallback? get onClear => widget.onClear;
  String get label => widget.label;
  String get title => widget.title;
  void Function(T?) get onSelected => widget.onSelected;
  void Function(T?)? get onSaved => widget.onSaved;
  String? Function(T?)? get validator => widget.validator;
  bool get enabled => widget.enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final secondary = colorScheme.secondary;

    return DropdownSearch<T>(
      validator: validator,
      items: (filter, infiniteScrollProps) {
        return items..sort((a, b) => itemAsString(a).trim().compareTo(itemAsString(b).trim()));
      },
      itemAsString: itemAsString,
      compareFn: (a, b) => a == b,
      selectedItem: selectedItem,
      enabled: enabled,
      onSelected: onSelected,
      onSaved: onSaved,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label,
          fillColor: enabled ? Colors.white : Colors.grey.shade100,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: .50)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: primary, width: 1.2),
          ),
          labelStyle: TextStyles.instance.textRegular.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontFamily: 'Cabin',
          ),
          errorStyle: TextStyles.instance.textRegular.copyWith(color: colorScheme.error, fontFamily: 'Cabin'),
        ),
      ),
      suffixProps: DropdownSuffixProps(
        dropdownButtonProps: DropdownButtonProps(
          padding: const EdgeInsets.all(8),
          mouseCursor: SystemMouseCursors.click,
          alignment: Alignment.center,
          iconOpened: openOrClearFilter,
          iconClosed: openOrClearFilter,
        ),
      ),
      popupProps: PopupProps.dialog(
        fit: FlexFit.loose,
        showSelectedItems: true,
        constraints: BoxConstraints(minWidth: 500, maxWidth: 500, maxHeight: 375),
        dialogProps: DialogProps(
          actions: [TextButton(onPressed: () => Modular.to.pop(), child: Text('Fechar'))],
          actionsPadding: const EdgeInsets.only(bottom: 15, right: 15),
          contentPadding: const EdgeInsets.all(10),
          insetPadding: const EdgeInsets.all(15),
        ),
        scrollbarProps: ScrollbarProps(thumbColor: primary.withValues(alpha: .5)),
        loadingBuilder: (_, _) => const Center(child: CircularProgressIndicator()),
        showSearchBox: controller != null,
        searchDelay: Duration.zero,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
          child: Text(title, style: context.textStyles.textTitle.copyWith(fontSize: 22)),
        ),
        searchFieldProps: TextFieldProps(
          autofocus: true,
          decoration: const InputDecoration(label: Text('Pesquise'), suffixIcon: Icon(Icons.search)),
          onSelected: (value) {
            if (controller != null) {
              controller?.setFiltro(value);
            }
          },
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
            if (controller != null) controller?.setFiltro('');
          },
        ),
        emptyBuilder: (_, _) {
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Builder(
              builder: (context) {
                if (controller == null) {
                  return Text(textAlign: .justify, 'Nenhum item encontrado ', style: TextStyle(fontSize: 15));
                }

                return Text(
                  textAlign: .justify,
                  'Nenhum item encontrado para o filtro "${controller?.filtro ?? ''}".',
                  style: TextStyle(fontSize: 15),
                );
              },
            ),
          );
        },
        itemBuilder: (_, item, _, isSelected) {
          final value = itemAsString(item);
          final isCurrent = item == selectedItem;
          final normQuery = controller != null ? (controller?.filtro ?? '').toLowerCase().normalizar() : '';
          final text = value.toUpperCase().trim();

          if (normQuery.isEmpty) {
            return Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isCurrent ? primary.withValues(alpha: .15) : null,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: Icon(
                  isCurrent ? Icons.check_circle_rounded : Icons.circle_outlined,
                  color: isCurrent ? primary : Colors.grey,
                ),
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text(
                  text,
                  textAlign: .justify,
                  style: TextStyle(fontWeight: .w700),
                ),
                subtitle: Text(
                  'SSSSSSSSSSSSSSSSSSSSSSSSS',
                  textAlign: .justify,
                  style: TextStyle(fontWeight: .normal),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            );
          }

          final spans = <TextSpan>[];
          final normalizedText = text.toLowerCase().normalizar();
          int start = 0;
          int index;

          while ((index = normalizedText.indexOf(normQuery, start)) != -1) {
            if (index > start) {
              spans.add(TextSpan(text: text.substring(start, index)));
            }

            spans.add(
              TextSpan(
                text: text.substring(index, index + normQuery.length),
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, backgroundColor: secondary),
              ),
            );
            start = index + normQuery.length;
          }

          if (start < text.length) {
            spans.add(TextSpan(text: text.substring(start)));
          }

          return Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isCurrent ? primary.withValues(alpha: .15) : null,
            ),
            child: ListTile(
              leading: Icon(
                isCurrent ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isCurrent ? primary : Colors.grey,
              ),
              dense: true,
              visualDensity: VisualDensity.compact,
              title: RichText(
                text: TextSpan(
                  children: spans,
                  style: const TextStyle(color: Colors.black, fontFamily: 'Cabin'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get openOrClearFilter {
    if (selectedItem == null || onClear == null) {
      return const Icon(Icons.arrow_drop_down);
    }

    return InkWell(
      child: const Icon(Icons.close_rounded, size: 17, color: Colors.black),
      onTap: () {
        onClear?.call();
        if (controller != null) controller?.setFiltro('');
      },
    );
  }
}
