import 'package:flutter/material.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_question_answer_section.dart';

import '../../../config/config_index.dart';

class QuizQuestionAnswerSection extends StatefulWidget {
  const QuizQuestionAnswerSection({
    super.key,
    required this.currentQuestionIndex,
    required this.quizData,
    required this.handleOptionTap,
  });

  final int currentQuestionIndex;
  final Function(int) handleOptionTap;
  final List<Map<String, dynamic>> quizData;

  @override
  State<QuizQuestionAnswerSection> createState() =>
      _QuizQuestionAnswerSectionState();
}

class _QuizQuestionAnswerSectionState extends State<QuizQuestionAnswerSection> {
  late int _selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion =
        widget.quizData[widget.currentQuestionIndex];
    List<String> options = currentQuestion['options'];

    return Column(
      children: [
        QuizQuestionSection(
          number: '${widget.currentQuestionIndex + 1} / 10 ',
          question: currentQuestion['question'],
        ),
        GridView.count(
          childAspectRatio: 3,
          crossAxisCount: 2,
          shrinkWrap: true,
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
                  widget.handleOptionTap(value);
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
  }
}
