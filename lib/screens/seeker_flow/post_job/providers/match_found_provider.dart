import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/models/match_model.dart';
import 'package:haathbarhao_mobile/providers/tasks_repo_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';

import 'package:haathbarhao_mobile/utils/get_latlng_from_location.dart';

final matchFoundProvider = StateNotifierProvider.autoDispose
    .family<MatchFoundNotifier, MatchFoundState, String>((ref, id) {
  final tasksRepository = ref.read(tasksRepositoryProvider);
  return MatchFoundNotifier(tasksRepository, ref, id);
});

class MatchFoundNotifier extends StateNotifier<MatchFoundState> {
  final TaskRepository tasksRepository;
  final Ref ref;
  final String id;

  MatchFoundNotifier(this.tasksRepository, this.ref, this.id)
      : super(MatchFoundState(isLoading: true, matches: [])) {
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      final hasPermission = await handleLocationPermission();
      if (!hasPermission) {
        throw 'Need location permission access to continue.';
      }

      // Get current location
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final lat = position.latitude;
      final lng = position.longitude;

      // Fetch matches
      final matches = await tasksRepository.getMatches(id, lat, lng);

      state = state.copyWith(
        isLoading: false,
        matches: matches,
      );
    } catch (e) {
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
  }
}

class MatchFoundState {
  final bool isLoading;
  final List<MatchModel> matches;

  MatchFoundState({
    required this.isLoading,
    required this.matches,
  });

  MatchFoundState copyWith({
    bool? isLoading,
    List<MatchModel>? matches,
  }) {
    return MatchFoundState(
      isLoading: isLoading ?? this.isLoading,
      matches: matches ?? this.matches,
    );
  }
}
