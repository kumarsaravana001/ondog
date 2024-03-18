import 'package:flutter_bloc/flutter_bloc.dart';

class ShowIdCubit extends Cubit<int> {
  ShowIdCubit() : super(0);

  void updateShowId(int showId) => emit(showId);
}

class EpisodeIdCubit extends Cubit<int> {
  EpisodeIdCubit() : super(0);

  void updateEpisodeId(int episodeId) => emit(episodeId);
}

class EpisodeCubit extends Cubit<String?> {
  EpisodeCubit() : super(null);

  void selectEpisode(String episodeUrl) => emit(episodeUrl);
}
