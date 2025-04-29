import 'package:flutter/material.dart';

class HeaderDropdownItems extends StatefulWidget {
  final String title;
  final Map<String, String> menuItems;

  const HeaderDropdownItems({
    required this.title,
    required this.menuItems,
    super.key,
  });

  @override
  State<HeaderDropdownItems> createState() => _HeaderDropdownHoverState();
}

class _HeaderDropdownHoverState extends State<HeaderDropdownItems> {
  OverlayEntry? _overlayEntry;
  bool isPointerInsideOverlay = false;
  bool isPointerInsideTrigger = false;

  void _showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: offset.dy + renderBox.size.height,
            left: offset.dx,
            child: MouseRegion(
              onEnter: (_) => isPointerInsideOverlay = true,
              onExit: (_) {
                isPointerInsideOverlay = false;
                _delayedRemove();
              },
              child: Material(
                elevation: 4,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      widget.menuItems.entries.map((entry) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, entry.value);
                            _removeOverlay();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Text(entry.key),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _delayedRemove() {
    Future.delayed(Duration(milliseconds: 150), () {
      if (!isPointerInsideTrigger && !isPointerInsideOverlay) {
        _removeOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        isPointerInsideTrigger = true;
        _showOverlay(context);
      },
      onExit: (_) {
        isPointerInsideTrigger = false;
        _delayedRemove();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
