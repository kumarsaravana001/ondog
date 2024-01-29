// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc.dart/bloc/popular_picks_bloc.dart';
// import 'package:ondgo_flutter/bloc/homescreen_bloc/popular_picks_bloc.dart/bloc/popular_picks_state.dart';
// Stack(
//   children: [
//     Padding(
//       padding: EdgeInsets.only(bottom: 22.sp),
//       child: SvgPicture.asset(IconAssets.appbackground),
//     ),
//     Center(
//       child: Text(AppLocalisation.popularpicks,
//           style: AppTestStyle.headingBai(
//               fontSize: 22.sp,
//               color: AppColors.black,
//               fontWeight: FontWeight.w800)),
//     ),
//     Padding(
//       padding: EdgeInsets.only(left: 20.0.sp, top: 30.sp),
//       child: BlocBuilder<PopularPicksBloc, PopularPicksState>(
//         builder: (context, state) {
//           if (state is PopularPicksLoading) {
//             return CircularProgressIndicator();
//           } else if (state is PopularPicksLoaded) {
//             return HorizontalScrollableCard(
//               cardStatusColor: Colors.indigoAccent,
//               titlecard: state.popularPicks.map((pick) => pick.showName ?? 'Unknown Show').toList(),
//               imageListCount: state.popularPicks.length,
//               imageList: state.popularPicks.map((pick) => pick.thumbnail != null && pick.thumbnail!.isNotEmpty ? pick.thumbnail!.first : 'default_image_url').toList(),
//               textColor: AppColors.white,
//             );
//           } else if (state is PopularPicksError) {
//             return Text('Error: ${state.message}');
//           }
//           return Container(); // Placeholder for other states
//         },
//       ),
//     ),
//   ],
// ),
