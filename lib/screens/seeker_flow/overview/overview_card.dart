import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/models/tasks_model.dart';
import 'package:haathbarhao_mobile/providers/go_router.dart';
import 'package:haathbarhao_mobile/widgets/secondary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OverviewCard extends ConsumerStatefulWidget {
  final Task task;

  const OverviewCard({
    required this.task,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<OverviewCard> {
  cancelOrder() async {
    final url = Uri.parse(
        'https://wa.me/923237399596?text=I%20need%20help%20canceling%20my%20task.');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  trackOnPressed(String mapsUrl) async {
    final url = Uri.parse(mapsUrl);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  rateOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ColorName.white,
        border: Border.all(
          color: ColorName.black.withOpacity(0.11),
        ),
        borderRadius: BorderRadius.circular(18.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 65,
                width: 65,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(2, 3),
                      blurRadius: 3,
                      spreadRadius: 0,
                      color: const Color(0xFFD3D1D8).withOpacity(0.2),
                    ),
                  ],
                ),
                child:
                    widget.task.photos != null && widget.task.photos!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.task.photos!.first,
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.task.location}  •  ${widget.task.category}  •  #${widget.task.id!.substring(15)}',
                      style: const TextStyle(
                        fontFamily: FontFamily.clashDisplay,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF9796A1),
                      ),
                    ),
                    Text(
                      widget.task.title!,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.55,
                        color: ColorName.black,
                      ),
                    ),
                    if (widget.task.status == 'Open' ||
                        widget.task.status == 'Assigned' ||
                        widget.task.status == 'Completed')
                      Row(
                        children: [
                          Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              color: widget.task.status == 'cancelled' ||
                                      widget.task.status == 'rejected'
                                  ? ColorName.primary
                                  : const Color(0xFF029094),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (widget.task.status!.toLowerCase() == 'open')
                            const Text(
                              'Task is upcoming.',
                              style: TextStyle(
                                fontFamily: FontFamily.clashDisplay,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF029094),
                              ),
                            ),
                          if (widget.task.status!.toLowerCase() == 'assigned')
                            const Text(
                              'Task is ongoing.',
                              style: TextStyle(
                                fontFamily: FontFamily.clashDisplay,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF029094),
                              ),
                            ),
                          if (widget.task.status!.toLowerCase() == 'completed')
                            const Text(
                              'Task is complete.',
                              style: TextStyle(
                                fontFamily: FontFamily.clashDisplay,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFF029094),
                              ),
                            ),
                        ],
                      ),
                    if (widget.task.status == 'cancelled' ||
                        widget.task.status == 'rejected')
                      Row(
                        children: [
                          Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                              color: widget.task.status == 'cancelled' ||
                                      widget.task.status == 'rejected'
                                  ? ColorName.primary
                                  : const Color(0xFF029094),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.task.status == 'cancelled'
                                ? 'Task cancelled.'
                                : 'Task rejected.',
                            style: TextStyle(
                              fontFamily: FontFamily.clashDisplay,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: widget.task.status == 'cancelled' ||
                                      widget.task.status == 'rejected'
                                  ? ColorName.primary
                                  : const Color(0xFF029094),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 43,
                  child: SecondaryButton(
                    outlined: true,
                    text: widget.task.status == 'Open' ? 'Chat' : 'Rate',
                    textStyle: const TextStyle(
                      fontFamily: FontFamily.clashDisplay,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorName.black,
                    ),
                    onPressed: widget.task.status == 'Open'
                        ? () {
                            context.goNamed(
                              AppRoute.chatPage.name,
                            );
                          }
                        : rateOnPressed,
                  ),
                ),
              ),
              const SizedBox(width: 21),
              Expanded(
                child: SizedBox(
                  height: 43,
                  child: SecondaryButton(
                    text: widget.task.status == 'Open'
                        ? 'See Applicants'
                        : 'Repost',
                    textStyle: const TextStyle(
                      fontFamily: FontFamily.clashDisplay,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorName.white,
                    ),
                    onPressed: () {
                      if (widget.task.status == 'Open') {
                        context.goNamed(
                          AppRoute.matchFoundView.name,
                          pathParameters: {
                            "id": widget.task.id ?? '',
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
