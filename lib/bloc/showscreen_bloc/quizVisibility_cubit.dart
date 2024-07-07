import 'package:flutter_bloc/flutter_bloc.dart';

class QuizVisibilityCubit extends Cubit<bool> {
  QuizVisibilityCubit() : super(false);

  void toggleQuizVisibility() => emit(!state);
}
