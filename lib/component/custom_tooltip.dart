import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class CustomTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final String? copiedText;

  const CustomTooltip(
      {Key? key, required this.message, required this.child, this.copiedText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return SizedBox(
      child: Tooltip(
        margin: const EdgeInsets.only(right: 8),
        key: key,
        message: message,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTap(key),
          child: child,
        ),
      ),
    );
  }

  void _onTap(GlobalKey key) async {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
    await FlutterClipboard.copy(copiedText!);
  }
}
