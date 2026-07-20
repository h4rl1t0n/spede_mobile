import 'package:flutter/material.dart';

import '../../theme/styles/text_styles.dart';

class CustomDropdownSearch<T> extends StatefulWidget {
  final bool enabled;
  final List<T> items;
  final T? initialValue;
  final String hintText;
  final String Function(T item) title;
  final String Function(T item)? subtitle;
  final ValueChanged<T?>? onSelected;
  final VoidCallback? onClear;

  const CustomDropdownSearch({
    super.key,
    required this.items,
    required this.title,
    this.initialValue,
    this.subtitle,
    this.enabled = true,
    this.hintText = 'Selecione...',
    this.onSelected,
    this.onClear,
  });

  @override
  State<CustomDropdownSearch<T>> createState() => _CustomDropdownSearchState<T>();
}

class _CustomDropdownSearchState<T> extends State<CustomDropdownSearch<T>> {
  List<T> get items => widget.items;
  String Function(T) get title => widget.title;
  String Function(T)? get subtitle => widget.subtitle;
  T? get initialValue => widget.initialValue;
  String get hintText => widget.hintText;
  ValueChanged<T?>? get onSelected => widget.onSelected;
  bool get enabled => widget.enabled;
  VoidCallback? get onClear => widget.onClear;

  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: initialValue == null ? '' : title(initialValue as T));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDropdownSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      controller.text = widget.initialValue == null ? '' : title(widget.initialValue as T);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DropdownMenu<T>(
      enabled: enabled,
      controller: controller,
      width: size.width - 32,
      hintText: hintText,
      initialSelection: initialValue,
      enableSearch: true,
      enableFilter: true,
      requestFocusOnTap: false,
      dropdownMenuEntries: items
          .map(
            (item) => DropdownMenuEntry<T>(
              value: item,
              labelWidget: ListTile(
                dense: true,
                title: Text(title(item), style: context.textStyles.textTitleItemList.copyWith(fontSize: 14)),
                subtitle: subtitle != null
                    ? Text(subtitle!.call(item), style: context.textStyles.textSubTitleItemList.copyWith(fontSize: 13))
                    : null,
                trailing: Icon(Icons.chevron_right),
              ),
              label: title(item),
            ),
          )
          .toList(),
      onSelected: onSelected,
      trailingIcon: onClear == null
          ? null
          : initialValue == null
          ? Icon(Icons.arrow_drop_down)
          : GestureDetector(onTap: limpar, child: Icon(Icons.close, size: 16)),
    );
  }

  void limpar() {
    controller.clear();
    onClear?.call();
  }
}
