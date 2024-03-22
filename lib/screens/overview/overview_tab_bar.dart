// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/static_providers.dart';
import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';

class OverviewTabBar extends ConsumerStatefulWidget {
  final String text;
  final int index;
  final int currentIndex;

  const OverviewTabBar({
    required this.text,
    required this.index,
    required this.currentIndex,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends ConsumerState<OverviewTabBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(overviewTabSelectedIndexProvider.notifier).state =
              widget.index;
        },
        child: Container(
          height: 47,
          decoration: BoxDecoration(
            color: widget.currentIndex == widget.index
                ? ColorName.primary
                : ColorName.transparentColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: widget.currentIndex == widget.index
                ? [
                    BoxShadow(
                      offset: const Offset(0, 18),
                      blurRadius: 40,
                      spreadRadius: 0,
                      color: const Color(0xFFD3D1D8).withOpacity(0.25),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontFamily.clashDisplay,
                color: widget.currentIndex == widget.index
                    ? ColorName.white
                    : ColorName.primary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
