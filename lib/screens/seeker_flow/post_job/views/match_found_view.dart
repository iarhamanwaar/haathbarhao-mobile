import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/post_job/providers/match_found_provider.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/post_job/widgets/match_card.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class MatchFoundView extends ConsumerWidget {
  final String id;

  const MatchFoundView({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(matchFoundProvider(id));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 10,
        leading: const SizedBox.shrink(),
        title: const Text(
          'Match Found',
          style: TextStyle(
            fontFamily: FontFamily.clashDisplay,
            fontWeight: FontWeight.w600,
            fontSize: 32,
            color: ColorName.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.close,
                color: ColorName.black,
                size: 35,
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: state.matches.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.matches.length,
                            itemBuilder: (context, index) {
                              final match = state.matches[index];
                              return MatchCard(
                                match: match,
                              );
                            },
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                'No matches found for your task yet, please check back later in a few hours.',
                                style: TextStyle(
                                  fontFamily: FontFamily.clashDisplay,
                                ),
                              ),
                            ),
                          ),
                  ),
                  PrimaryButton(
                    text: 'Wait for applicants',
                    onPressed: () {
                      context.pop();
                    },
                    invertColors: true,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
