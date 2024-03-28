import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/step1/step1_view.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/step2_view.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/step3_view.dart';

class BecomeHelperView extends ConsumerStatefulWidget {
  const BecomeHelperView({super.key});

  @override
  ConsumerState createState() => _BecomeHelperViewState();
}

class _BecomeHelperViewState extends ConsumerState<BecomeHelperView> {
  PageController pageController = PageController();
  int pageIndex = 0;

  List<Widget> pages = [];

  leadingOnPressed() {
    FocusScope.of(context).unfocus();

    pageController.animateToPage(
      --pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  nextOnPressed() {
    FocusScope.of(context).unfocus();

    pageController.animateToPage(
      ++pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: pageIndex,
    );

    pages = [
      Step1View(
        nextOnPressed: nextOnPressed,
      ),
      Step2View(
        nextOnPressed: nextOnPressed,
      ),
      Step3View(
        nextOnPressed: nextOnPressed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7FC),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 4,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: pages.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      height: 4,
                      width: (MediaQuery.of(context).size.width -
                              36 -
                              (6 * (pages.length))) /
                          (pages.length),
                      decoration: BoxDecoration(
                        color:
                            pageIndex >= i ? ColorName.primary : ColorName.grey,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int i) {
                    return const SizedBox(width: 6);
                  },
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: pages,
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
