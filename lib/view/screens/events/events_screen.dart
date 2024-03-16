import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/events_bloc/event_bloc.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/events_bloc/event_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/events_bloc/event_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_vertical_scroll_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventDetailsBloc>(
            create: (context) => EventDetailsBloc()..add(FetchEventDetails())),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                bottom: -125,
                left: -10,
                right: 30,
                child: SvgPicture.asset(IconAssets.bottombgdiamond),
              ),
              Column(
                children: [
                  SvgPicture.asset(
                      width: MediaQuery.of(context).size.width,
                      IconAssets.profilescreenbgblack),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalisation.events,
                      style:GoogleFonts.baiJamjuree(fontSize: 28.sp),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0.sp, top: 30.sp, right: 10.sp),
                      child: BlocBuilder<EventDetailsBloc, EventDetailsState>(
                        builder: (context, state) {
                          if (state is EventDetailsLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is EventDetailsLoaded &&
                              state.eventDetails.isNotEmpty) {
                            List<String> showNames = state.eventDetails
                                .map(
                                    (show) => show.eventTitle ?? 'No Show Name')
                                .toList();

                            // List<Widget> imageWidgets =
                            //     state.eventDetails.map((show) {
                            //   String imageUrl = show.imagePath!.isNotEmpty
                            //       ? show.imagePath![0]
                            //       : 'assets/images/art_banner.png';

                            //   return Image.network(imageUrl, fit: BoxFit.cover);
                            // }).toList();
                            List<Widget> imageWidgets =
                                state.eventDetails.map((show) {
                              // Assuming `show.imagePath` is a String. Adjust if it's actually a List.
                              String imageUrl = Uri.tryParse(
                                              show.imagePath ?? '')
                                          ?.isAbsolute ==
                                      true
                                  ? show.imagePath!
                                  : 'assets/images/art_banner.png'; // Fallback to a local asset or a valid network URL

                              // Check if imageUrl starts with 'http' to ensure it's a network image
                              if (imageUrl.startsWith('http')) {
                                return Image.network(imageUrl,
                                    fit: BoxFit.cover);
                              } else {
                                // Fallback for local assets or invalid URLs
                                return Image.asset(
                                    'assets/images/art_banner.png',
                                    fit: BoxFit.cover);
                              }
                            }).toList();

                            return AppVerticalScrollCard(
                              imageList: imageWidgets,
                              titlecard: showNames,
                            );
                          } else if (state is EventDetailsLoading) {
                            return horizontalCardShimmerWidget();
                          } else {
                            return horizontalCardShimmerWidget();
                          }
                        },
                      ),
                    ),
                    //  Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    //     child: AppVerticalScrollCard()),
                  ),
                  //SizedBox(height: 4.h),
                ],
              ),
              Positioned(
                top: 0,
                right: 30,
                child: Row(
                  children: [SvgPicture.asset(IconAssets.badgeopen)],
                ),
              ),
              Positioned(
                top: 10,
                left: 20,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_outlined,
                          color: AppColors.white, size: 30),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
