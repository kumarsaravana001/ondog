import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_bloc.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/rewards_bloc/rewards_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';
import '../../../config/config_index.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RewardsBloc>().add(FetchRewardsUrls());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      AppLocalisation.rewards,
                      style: GoogleFonts.baiJamjuree(
                        fontSize: 24.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    )),
                // Expanded(
                //   child: ElongatedCardWidget(
                //     cardlength: rewardsimagePaths.length,
                //     imageList: rewardsimagePaths,
                //     sublabel: AppLocalisation.coffeewithcrypto,
                //     label: AppLocalisation.offer,
                //     amount: AppLocalisation.inramount,
                //     date: AppLocalisation.date,
                //     onPressed: () {},
                //   ),
                // ),

                BlocBuilder<RewardsBloc, RewardsState>(
                  builder: (context, state) {
                    if (state is RewardsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RewardsLoaded) {
                      return Container(
                        height: 500,
                        child: ListView.builder(
                          itemCount: state.rewardsUrls.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 18.sp,
                                  right: 18.sp,
                                  bottom: 10.sp,
                                  top: 20.sp),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                      state.rewardsUrls[index].rewardurl),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is RewardsError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return horizontalCardShimmerWidget();
                  },
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 30,
              child: Row(
                children: [
                  SvgPicture.asset(IconAssets.badgeopen),
                ],
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
    );
  }
}
