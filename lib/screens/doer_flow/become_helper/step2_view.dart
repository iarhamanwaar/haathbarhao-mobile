import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step2View extends ConsumerStatefulWidget {
  final Function() nextOnPressed;

  const Step2View({
    required this.nextOnPressed,
    super.key,
  });

  @override
  ConsumerState createState() => _Step2ViewState();
}

class _Step2ViewState extends ConsumerState<Step2View> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
