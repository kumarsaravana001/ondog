// import 'package:flutter/material.dart';
// import 'package:ondgo_flutter/view/screens/showcase/qna_placeholder.dart';

// import '../../../config/config_index.dart';

// class QuizQuestionAnswerSection extends StatefulWidget {
//   // const QuizQuestionAnswerSection({
//   //   super.key,
//   //   required this.currentQuestionIndex,
//   //   required this.quizData,
//   //   required this.handleOptionTap,
//   // });

//   // final int currentQuestionIndex;
//   // final Function(int) handleOptionTap;
//   // final List<Map<String, dynamic>> quizData;

//   @override
//   State<QuizQuestionAnswerSection> createState() =>
//       _QuizQuestionAnswerSectionState();
// }

// class _QuizQuestionAnswerSectionState extends State<QuizQuestionAnswerSection> {
//   late int _selectedOptionIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> currentQuestion =
//         widget.quizData[widget.currentQuestionIndex];
//     List<String> options = currentQuestion['options'];

//     return Column(
//       children: [
//         QuizQuestionSection(
//           number: '${widget.currentQuestionIndex + 1} / 10 ',
//           question: currentQuestion['question'],
//         ),
//         GridView.count(
//           childAspectRatio: 3,
//           crossAxisCount: 2,
//           shrinkWrap: true,
//           children: List.generate(
//             options.length,
//             (index) => RadioListTile<int>(
//               activeColor: AppColors.black,
//               contentPadding: EdgeInsets.zero,
//               dense: true,
//               title: Text(options[index]),
//               value: index,
//               groupValue: _selectedOptionIndex,
//               onChanged: (int? value) {
//                 if (value != null) {
//                   widget.handleOptionTap(value);
//                   setState(() {
//                     _selectedOptionIndex = value;
//                   });
//                 }
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/quizDetails_bloc/quizdetail_state.dart';
import 'package:ondgo_flutter/view/screens/showcase/qna_placeholder.dart';
import '../../../config/config_index.dart';

class QuizQuestionAnswerSection extends StatefulWidget {
  const QuizQuestionAnswerSection({Key? key}) : super(key: key);

  @override
  State<QuizQuestionAnswerSection> createState() =>
      _QuizQuestionAnswerSectionState();
}

class _QuizQuestionAnswerSectionState extends State<QuizQuestionAnswerSection> {
  late int _selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizDetailsBloc, QuizDetailsState>(
      builder: (context, state) {
        if (state is QuizDetailsLoading) {
          return const CircularProgressIndicator();
        } else if (state is QuizDetailsLoaded) {
          final currentQuestion =
              state.quizDetails.first; // Assuming you want the first question
          final options =
              currentQuestion.choices; // Assuming choices are stored in a list

          return Column(
            children: [
              QuizQuestionSection(
                number: '1 / ${state.quizDetails.length}', // Adjust accordingly
                question: currentQuestion.question.toString(),
              ),
              GridView.count(
                childAspectRatio: 3,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // To avoid scrolling within the GridView
                children: List.generate(
                  options!.length,
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
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is QuizDetailsError) {
          return Text('Error: ${state.message}');
        }
        return const Text(
            'Please start the quiz.'); // This text is shown by default
      },
    );
  }
}
