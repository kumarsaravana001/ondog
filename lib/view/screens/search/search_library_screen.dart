import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ondgo_flutter/utilities/app_banner_list.dart';
import '../../../bloc/search_bloc/search_bloc.dart';
import '../../../bloc/search_bloc/search_event.dart';
import '../../../bloc/search_bloc/search_state.dart';
import '../../../config/config_index.dart';
import '../../../utilities/app_bg.dart';
import '../../../utilities/app_horizontal_scroll_card.dart';
import '../../../utilities/index.dart';

class SearchandLibraryScreen extends StatefulWidget {
  const SearchandLibraryScreen({super.key});

  @override
  State<SearchandLibraryScreen> createState() => _SearchandLibraryScreenState();
}

class _SearchandLibraryScreenState extends State<SearchandLibraryScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String userId = Hive.box('sessionBox').get('userId', defaultValue: '');
    if (userId.isNotEmpty) {
      context
          .read<SearchBloc>()
          .add(FetchCategories(userId: userId, query: searchController.text));
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: Hometopshape1(),
                child: Stack(
                  children: [
                    Container(
                      height: 30.h,
                      color: AppColors.black,
                    ),
                    Positioned(
                      top: 0,
                      right: 30,
                      child: Row(
                        children: [
                          SvgPicture.asset(IconAssets.badgecloseblack)
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: 38.sp, left: 20.sp, right: 20.sp),
                      child: CustomTextField(
                        controller: searchController,
                        hintText: "Search",
                        borderColor: AppColors.white,
                        textColor: AppColors.black,
                        suffixIcon: Icons.search,
                        onSuffixIconPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  SvgPicture.asset(IconAssets.spotlightbgframe2,
                      height: 35.h, fit: BoxFit.cover),
                  Positioned(
                    left: 20.sp,
                    right: 05.sp,
                    child: Column(
                      children: [
                        Text(
                          AppLocalisation.sprituality,
                          style: AppTestStyle.headingBai(fontSize: 26.sp),
                        ),
                        HorizontalScrollableCard(
                          cardStatusColor: Colors.yellow[300]!,
                          titlecard: spritualityimagepathtitle,
                          imageListCount: sritualityImagepath.length,
                          imageList: sritualityImagepath,
                          textColor: AppColors.white,
                          subtitle: AppLocalisation.ratingcount,
                          onTap: (String showId) {},
                          showIds: [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
