import 'package:flutter/material.dart';

class CustomDropdownSearch<T> extends StatefulWidget {
  final bool enabled;
  final List<T> items;
  final T? initialValue;
  final String hintText;
  final String Function(T item) itemString;
  final ValueChanged<T?>? onSelected;

  const CustomDropdownSearch({
    super.key,
    required this.items,
    required this.itemString,
    this.initialValue,
    this.enabled = true,
    this.hintText = 'Selecione...',
    this.onSelected,
  });

  @override
  State<CustomDropdownSearch<T>> createState() => _CustomDropdownSearchState<T>();
}

class _CustomDropdownSearchState<T> extends State<CustomDropdownSearch<T>> {
  List<T> get items => widget.items;
  String Function(T) get itemString => widget.itemString;
  T? get initialValue => widget.initialValue;
  String get hintText => widget.hintText;
  ValueChanged<T?>? get onSelected => widget.onSelected;
  bool get enabled => widget.enabled;

  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
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
      enableFilter: false,
      enableSearch: false,
      requestFocusOnTap: true,
      // searchCallback: (entries, query) {
      //   if (query.isEmpty) return null;

      //   final index = entries.indexWhere((entry) {
      //     return entry.label.toLowerCase().contains(query.toLowerCase());
      //   });

      //   return index == -1 ? null : index;
      // },
      dropdownMenuEntries: items.map((item) => DropdownMenuEntry<T>(value: item, label: itemString(item))).toList(),
      onSelected: onSelected,
    );
  }
}
