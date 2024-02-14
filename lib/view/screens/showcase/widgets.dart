import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_bloc.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_event.dart';
import 'package:ondgo_flutter/bloc/showscreen_bloc/showDetails_bloc/show_details_state.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import 'package:ondgo_flutter/view/screens/showcase/media_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/question_answer.dart';
import 'package:ondgo_flutter/view/screens/showcase/quiz_content.dart';
import 'package:ondgo_flutter/view/screens/showcase/score_widget_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/show_case_card_section.dart';
import 'package:ondgo_flutter/view/screens/showcase/watch_media_section.dart';
import '../../../bloc/showscreen_bloc/showId_cubit.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_custombar.dart';

class show_Title_Desc_Widget extends StatelessWidget {
  const show_Title_Desc_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserShowDetailBloc, UserShowDetailState>(
      builder: (context, state) {
        if (state is UserShowDetailLoading) {
          return buildTextShimmerEffect();
        } else if (state is UserShowDetailLoaded) {
          final showDetails =
              state.userDetails.isNotEmpty ? state.userDetails.first : null;
          return buildShowDetails(showDetails);
        } else if (state is UserShowDetailError) {
          return Text('Error: ${state.message}');
        }
        return const Text('Please select a show.');
      },
    );
  }
}

Widget buildShowDetails(ShowDetailsData? showDetails) {
  if (showDetails == null) return const Text('No details available');
  return Padding(
    padding: EdgeInsets.only(top: 10.sp, left: 18.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showDetails.showName ?? 'Show Name Not Available',
          style: AppTestStyle.headingBai(
            fontSize: 22.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Text(
            showDetails.description ?? 'Description Not Available',
            style: AppTestStyle.headingint(
              fontSize: 17.sp,
              italic: true,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
