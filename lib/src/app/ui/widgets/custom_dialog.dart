
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final Widget child;

  const CustomDialog({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: Material(
              type: MaterialType.card,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
