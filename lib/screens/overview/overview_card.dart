// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:haathbarhao_mobile/widgets/secondary_button.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../gen/colors.gen.dart';
// import '../../gen/fonts.gen.dart';
//
// class OverviewCard extends ConsumerStatefulWidget {
//   final Order order;
//
//   const OverviewCard({
//     required this.order,
//     super.key,
//   });
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _OrderCardState();
// }
//
// class _OrderCardState extends ConsumerState<OverviewCard> {
//   // reOrderOnPressed() async {
//   //   FocusManager.instance.primaryFocus?.unfocus();
//   //   HapticFeedback.selectionClick();
//   //   final loading = ref.watch(loadingProvider.notifier);
//   //
//   //   try {
//   //     final cartRepository = ref.read(cartRepositoryProvider);
//   //
//   //     loading.state = true;
//   //
//   //     final int branchId = await cartRepository.reOrder(
//   //       orderId: widget.order.id!,
//   //     );
//   //
//   //     ref.read(branchIdProvider.notifier).state = branchId;
//   //
//   //     ref.invalidate(cartProvider);
//   //
//   //     loading.state = false;
//   //
//   //     if (mounted) context.goNamed(AppRoute.cart.name);
//   //   } catch (e) {
//   //     log(e.toString());
//   //     loading.state = false;
//   //   }
//   // }
//
//   cancelOrder() async {
//     final url = Uri.parse(
//         'https://wa.me/966531013669?text=I%20need%20help%20canceling%20my%20order.');
//
//     if (!await launchUrl(url)) {
//       throw Exception('Could not launch $url');
//     }
//   }
//
//   trackOnPressed(String mapsUrl) async {
//     final url = Uri.parse(mapsUrl);
//
//     if (!await launchUrl(url)) {
//       throw Exception('Could not launch $url');
//     }
//   }
//
//   // rateOnPressed() {
//   //   ref.read(orderProvider.notifier).state = widget.order;
//   //
//   //   context.goNamed(
//   //     AppRoute.rating.name,
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: ColorName.white,
//         border: Border.all(
//           color: ColorName.black.withOpacity(0.11),
//         ),
//         borderRadius: BorderRadius.circular(18.2),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 65,
//                 width: 65,
//                 padding: const EdgeInsets.all(9),
//                 decoration: BoxDecoration(
//                   color: ColorName.white,
//                   borderRadius: BorderRadius.circular(21),
//                   boxShadow: [
//                     BoxShadow(
//                       offset: const Offset(2, 3),
//                       blurRadius: 3,
//                       spreadRadius: 0,
//                       color: const Color(0xFFD3D1D8).withOpacity(0.2),
//                     ),
//                   ],
//                 ),
//                 child: CachedNetworkImage(
//                   imageUrl: widget.order.restaurant!.logo!,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         '${getItemText(widget.order.cartHistory!.cartItems!.length)}  •  ',
//                         style: TextStyle(
//                           fontFamily: FontFamily.clashDisplay,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                           color: const Color(0xFF9796A1),
//                         ),
//                       ),
//                       Text(
//                         '${widget.order.cartHistory!.subTotal!} ${widget.order.cartHistory!.subTotal! == 1.0 ? 'riyal'.tr() : 'riyals'.tr()}  •  ',
//                         style: TextStyle(
//                           fontFamily: FontFamily.clashDisplay,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                           color: const Color(0xFF9796A1),
//                         ),
//                       ),
//                       Text(
//                         '#${widget.order.id!}',
//                         style: TextStyle(
//                           fontFamily: FontFamily.clashDisplay,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                           color: const Color(0xFF9796A1),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     widget.order.restaurant!.branch!,
//                     style: TextStyle(
//                       fontFamily: FontFamily.clashDisplay,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14.55,
//                       color: ColorName.black,
//                     ),
//                   ),
//                   if (widget.order.status == 'pending' ||
//                       widget.order.status == 'preparing' ||
//                       widget.order.status == 'ready' ||
//                       widget.order.status == 'tableReady' ||
//                       widget.order.status == 'completed')
//                     Row(
//                       children: [
//                         Container(
//                           height: 7,
//                           width: 7,
//                           decoration: BoxDecoration(
//                             color: widget.order.status == 'cancelled' ||
//                                     widget.order.status == 'rejected'
//                                 ? ColorName.primary
//                                 : const Color(0xFF029094),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         if (widget.order.status == 'pending')
//                           Text(
//                             'waitingForAcceptance'.tr(),
//                             style: TextStyle(
//                               fontFamily: FontFamily.clashDisplay,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                               color: const Color(0xFF029094),
//                             ),
//                           ),
//                         if (widget.order.status == 'preparing')
//                           Text(
//                             'orderIsBeingPrepared'.tr(),
//                             style: TextStyle(
//                               fontFamily: FontFamily.clashDisplay,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                               color: const Color(0xFF029094),
//                             ),
//                           ),
//                         if (widget.order.status == 'ready')
//                           Text(
//                             'orderIsReadyToPickup'.tr(),
//                             style: TextStyle(
//                               fontFamily: FontFamily.clashDisplay,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                               color: const Color(0xFF029094),
//                             ),
//                           ),
//                         if (widget.order.status == 'tableReady')
//                           Text(
//                             'yourTableIsReady'.tr(),
//                             style: TextStyle(
//                               fontFamily: FontFamily.clashDisplay,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                               color: const Color(0xFF029094),
//                             ),
//                           ),
//                         if (widget.order.status == 'completed')
//                           Text(
//                             'orderCompleted'.tr(),
//                             style: TextStyle(
//                               fontFamily: FontFamily.clashDisplay,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                               color: const Color(0xFF029094),
//                             ),
//                           ),
//                       ],
//                     ),
//                   if (widget.order.status != 'pending' &&
//                       widget.order.status != 'preparing' &&
//                       widget.order.status != 'ready' &&
//                       widget.order.status != 'tableReady' &&
//                       widget.order.status != 'completed')
//                     Row(
//                       children: [
//                         Container(
//                           height: 7,
//                           width: 7,
//                           decoration: BoxDecoration(
//                             color: widget.order.status == 'cancelled' ||
//                                     widget.order.status == 'rejected'
//                                 ? ColorName.primary
//                                 : const Color(0xFF029094),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           widget.order.status == 'cancelled'
//                               ? 'orderCancelled'.tr()
//                               : 'orderRejected'.tr(),
//                           style: TextStyle(
//                             fontFamily: FontFamily.clashDisplay,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12,
//                             color: widget.order.status == 'cancelled' ||
//                                     widget.order.status == 'rejected'
//                                 ? ColorName.primary
//                                 : const Color(0xFF029094),
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 21),
//           Row(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   height: 43,
//                   child: SecondaryButton(
//                     outlined: true,
//                     text: widget.order.status == 'pending' ||
//                             widget.order.status == 'preparing' ||
//                             widget.order.status == 'ready' ||
//                             widget.order.status == 'tableReady'
//                         ? 'cancel'.tr()
//                         : 'rate'.tr(),
//                     textStyle: TextStyle(
//                       fontFamily: FontFamily.clashDisplay,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: ColorName.black,
//                     ),
//                     onPressed: widget.order.status == 'pending' ||
//                             widget.order.status == 'preparing' ||
//                             widget.order.status == 'ready' ||
//                             widget.order.status == 'tableReady'
//                         ? cancelOrder
//                         : widget.order.rated! ||
//                                 widget.order.status == 'cancelled' ||
//                                 widget.order.status == 'rejected'
//                             ? null
//                             : rateOnPressed,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 21),
//               Expanded(
//                 child: SizedBox(
//                   height: 43,
//                   child: SecondaryButton(
//                     text: widget.order.status == 'pending' ||
//                             widget.order.status == 'preparing' ||
//                             widget.order.status == 'ready' ||
//                             widget.order.status == 'tableReady'
//                         ? 'location'.tr()
//                         : 'reOrder'.tr(),
//                     textStyle: TextStyle(
//                       fontFamily: FontFamily.clashDisplay,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: (widget.order.status == 'pending' ||
//                                       widget.order.status == 'preparing' ||
//                                       widget.order.status == 'ready' ||
//                                       widget.order.status == 'tableReady') &&
//                                   (widget.order.restaurant!.mapsUrl != null) ||
//                               (widget.order.status != 'pending' &&
//                                   widget.order.status != 'preparing' &&
//                                   widget.order.status != 'ready' &&
//                                   widget.order.status != 'tableReady')
//                           ? ColorName.white
//                           : ColorName.grey,
//                     ),
//                     onPressed: widget.order.status == 'pending' ||
//                             widget.order.status == 'preparing' ||
//                             widget.order.status == 'ready' ||
//                             widget.order.status == 'tableReady'
//                         ? widget.order.restaurant!.mapsUrl != null
//                             ? () => trackOnPressed(
//                                 widget.order.restaurant!.mapsUrl!)
//                             : null
//                         : reOrderOnPressed,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
