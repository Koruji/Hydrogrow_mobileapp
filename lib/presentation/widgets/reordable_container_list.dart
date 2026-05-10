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

  @override
  void didUpdateWidget(ReorderableContainerList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.titles.length != widget.titles.length) {
      containerOrder = List.generate(widget.titles.length, (index) => index);
      _saveOrder();
    }
  }

  Future<void> _loadOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList(widget.storageKey);

    if (savedOrder != null && savedOrder.length == widget.titles.length) {
      final parsed = savedOrder.map((e) => int.parse(e)).toList();
      final valid = parsed.every((i) => i >= 0 && i < widget.titles.length);
      if (valid) {
        setState(() {
          containerOrder = parsed;
        });
      } else {
        await resetOrder();
      }
    } else if (savedOrder != null) {
      await resetOrder();
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
    if (widget.isEditMode) {
      return ReorderableListView(
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
        children: List.generate(containerOrder.length, (index) {
          final originalIndex = containerOrder[index];
          return Container(
            key: ValueKey(originalIndex),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: widget.itemBuilder(widget.titles[originalIndex]),
                ),
                ReorderableDragStartListener(
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.drag_handle, size: 12),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    } else {
      return ListView(
        children: [
          if (widget.headerWidget != null) widget.headerWidget!,
          for (int i = 0; i < containerOrder.length; i++)
            widget.itemBuilder(widget.titles[containerOrder[i]]),
        ],
      );
    }
  }
}
