import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_state.dart';
import 'package:ondgo_flutter/view/screens/showcase/qna_placeholder.dart';
import '../../../config/config_index.dart';

class QuizQuestionAnswerSection extends StatefulWidget {
  const QuizQuestionAnswerSection({super.key});

  @override
  State<QuizQuestionAnswerSection> createState() =>
      _QuizQuestionAnswerSectionState();
}

class _QuizQuestionAnswerSectionState extends State<QuizQuestionAnswerSection> {
  late int _selectedOptionIndex = -1;
  int _currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizDetailsBloc, QuizDetailsState>(
      builder: (context, state) {
        if (state is QuizDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuizDetailsLoaded) {
          final currentQuestion = state.quizDetails[_currentQuestionIndex];

          final optionsString = currentQuestion.choices;
          final options = optionsString!.split(',');

          return Column(
            children: [
              QuizQuestionSection(
                number:
                    'Questions ${_currentQuestionIndex + 1} / ${state.quizDetails.length}',
                question: currentQuestion.question.toString(),
              ),
              GridView.count(
                childAspectRatio: 3,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  options.length,
                  (index) => RadioListTile<int>(
                    activeColor: AppColors.black,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(options[index]),
                    value: index,
                    groupValue: _selectedOptionIndex,
                    onChanged: (int? value) {
                      if (value != null) {
                        setState(() {
                          _selectedOptionIndex = value;
                          if (_currentQuestionIndex <
                              state.quizDetails.length - 1) {
                            _currentQuestionIndex++;
                          } else {
                            // print('Quiz Completed');
                          }
                          _selectedOptionIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is QuizDetailsError) {
          return const Center(child: Text('Select Episode and start the Quiz'));
          //Text('Error: ${state.message}');
        }
        return const Text('Select Episode and start the Quiz');
      },
    );
  }
}
