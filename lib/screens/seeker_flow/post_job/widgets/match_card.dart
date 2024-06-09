import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/models/match_model.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;

  const MatchCard({
    required this.match,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
              match.doer.profilePicture!,
            ),
          ),
          title: Text(
            match.doer.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorName.black,
            ),
          ),
          subtitle: Text(
            '${match.distance} | ${match.level}',
            style: const TextStyle(
              color: ColorName.black,
            ),
          ),
        ),
      ),
    );
  }
}
