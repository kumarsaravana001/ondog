import 'package:flutter_bloc/flutter_bloc.dart';

class ShowIdCubit extends Cubit<int> {
  ShowIdCubit() : super(0);

  void updateShowId(int showId) => emit(showId);
}
class EpisodeIdCubit extends Cubit<int> {
  EpisodeIdCubit() : super(0);

  void updateShowId(int showId) => emit(showId);
}
