import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_bloc.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_event.dart';
import 'package:ondgo_flutter/bloc/profile_bloc/purchase_bloc/purchase_state.dart';
import 'package:ondgo_flutter/view/screens/homescreen/widgets/widget.dart';

import '../../../config/config_index.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PurchaseBloc>().add(FetchPurchaseUrls());
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
              child: SvgPicture.asset(
                  width: MediaQuery.of(context).size.width,
                  IconAssets.bottombgdiamond),
            ),
            Column(
              children: [
                SvgPicture.asset(
                    width: MediaQuery.of(context).size.width,
                    IconAssets.profilescreenbgblack),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                      child: Text(
                        AppLocalisation.purchase,
                        style: GoogleFonts.baiJamjuree(
                          fontSize: 24.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )),
                // Expanded(
                //   child: ElongatedCardWidget(
                //     cardlength: purchadeimagePaths.length,
                //     imageList: purchadeimagePaths,
                //     sublabel: AppLocalisation.coffeewithcrypto,
                //     label: AppLocalisation.offer,
                //     amount: AppLocalisation.inramount,
                //     date: AppLocalisation.date,
                //     onPressed: () {},
                //   ),
                // ),

                BlocBuilder<PurchaseBloc, PurchaseState>(
                  builder: (context, state) {
                    if (state is PurchaseLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PurchaseLoaded) {
                      return SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: state.purchaseUrls.length,
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
                                      state.purchaseUrls[index].url),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is PurchaseError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return horizontalCardShimmerWidget();
                  },
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 22.sp,
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
    );
  }
}
