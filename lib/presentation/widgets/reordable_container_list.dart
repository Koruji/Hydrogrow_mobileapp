import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReorderableContainerList extends StatefulWidget {
  final List<String> titles;
  final Widget Function(String title) itemBuilder;
  final String storageKey;
  final bool isEditMode;
  final Widget? headerWidget;

  const ReorderableContainerList({
    super.key,
    required this.titles,
    required this.itemBuilder,
    required this.storageKey,
    this.isEditMode = false,
    this.headerWidget,
  });

  @override
  State<ReorderableContainerList> createState() =>
      _ReorderableContainerListState();
}

class _ReorderableContainerListState extends State<ReorderableContainerList> {
  late List<int> containerOrder;

  @override
  void initState() {
    super.initState();
    containerOrder = List.generate(widget.titles.length, (index) => index);
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList(widget.storageKey);

    if (savedOrder != null && savedOrder.length == widget.titles.length) {
      setState(() {
        containerOrder = savedOrder.map((e) => int.parse(e)).toList();
      });
    }
  }

  Future<void> _saveOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      widget.storageKey,
      containerOrder.map((e) => e.toString()).toList(),
    );
  }

  Future<void> resetOrder() async {
    setState(() {
      containerOrder = List.generate(widget.titles.length, (index) => index);
    });
    await _saveOrder();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEditMode
        ? ReorderableListView.builder(
            itemCount: containerOrder.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = containerOrder.removeAt(oldIndex);
                containerOrder.insert(newIndex, item);
              });
              _saveOrder();
            },
            itemBuilder: (context, index) {
              return widget.itemBuilder(widget.titles[containerOrder[index]]);
            },
          )
        : ListView(
            children: [
              if (widget.headerWidget != null) widget.headerWidget!,
              for (int i = 0; i < containerOrder.length; i++)
                widget.itemBuilder(widget.titles[containerOrder[i]]),
            ],
          );
  }
}
