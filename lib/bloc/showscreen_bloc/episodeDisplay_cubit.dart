import 'package:flutter_bloc/flutter_bloc.dart';

enum DisplayState { userDetails, videoDetails }

class DisplayBloc extends Cubit<DisplayState> {
  DisplayBloc() : super(DisplayState.userDetails);

  void showUserDetails() => emit(DisplayState.userDetails);
  void showVideoDetails() => emit(DisplayState.videoDetails);
}
