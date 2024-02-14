import 'package:flutter/material.dart';

import '../../../config/config_index.dart';

class QuizQuestionSection extends StatefulWidget {
  final String number;
  final String question;
  // final VoidCallback onNextPressed;
  const QuizQuestionSection({
    super.key,
    required this.number,
    required this.question,
    //required this.onNextPressed,
  });

  @override
  State<QuizQuestionSection> createState() => _QuizQuestionSectionState();
}

class _QuizQuestionSectionState extends State<QuizQuestionSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.number,
              style: AppTestStyle.headingint(
                  color: AppColors.black,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        Text(
          widget.question,
          style: AppTestStyle.headingint(
              color: AppColors.black,
              fontSize: 21.sp,
              fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class RoundRadio extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const RoundRadio({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(!value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? Colors.black : Colors.grey,
            width: 2.0,
          ),
        ),
        child: value
            ? Center(
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class GridQuestions extends StatefulWidget {
  final String label;
  final Function(bool) onSelectionChanged; // Function to handle selection

  const GridQuestions({
    Key? key,
    required this.label,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<GridQuestions> createState() => _GridQuestionsState();
}

class _GridQuestionsState extends State<GridQuestions> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundRadio(
          value: isSelected,
          onChanged: (newValue) {
            setState(() {
              isSelected = newValue ?? false;
              widget.onSelectionChanged(
                  isSelected); // Notify the parent about selection
            });
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTestStyle.headingint(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
