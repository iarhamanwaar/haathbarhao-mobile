import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Step3View extends ConsumerStatefulWidget {
  final Function() nextOnPressed;

  const Step3View({
    required this.nextOnPressed,
    super.key,
  });

  @override
  ConsumerState createState() => _Step3ViewState();
}

class _Step3ViewState extends ConsumerState<Step3View> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
