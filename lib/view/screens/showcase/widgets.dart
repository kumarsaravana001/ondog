import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/config_index.dart';
import 'package:ondgo_flutter/models/showscreen_modules/showscreen_modules.dart';

Widget buildShowDetails(ShowDetailsData? showDetails, BuildContext context) {
  if (showDetails == null) return const Text('No details available');
  return Padding(
    padding: EdgeInsets.only(top: 10.sp, left: 18.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              showDetails.showName ?? 'Show Name Not Available',
              style: GoogleFonts.baiJamjuree(
                fontSize: 22.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            //Padding(
            //padding: EdgeInsets.only(right: 20.sp),
            //child: InfoIconOverlay(),
            //),
            Padding(
                padding: EdgeInsets.only(right: 20.sp),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.black,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Glossary',
                                style: GoogleFonts.baiJamjuree(
                                  fontSize: 17.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close,
                                    color: AppColors.white, size: 15),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.sp),
                                  child: Text(
                                    'Artist : ${showDetails.actorArtist}' ??
                                        'Description Not Available',
                                    style: GoogleFonts.baiJamjuree(
                                      fontSize: 17.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Director : ${showDetails.director}' ??
                                      'Description Not Available',
                                  style: GoogleFonts.baiJamjuree(
                                    fontSize: 17.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.black,
                    size: 20,
                  ),
                )),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.sp, right: 15.sp),
          child: Text(
            showDetails.description ?? 'Description Not Available',
            style: GoogleFonts.baiJamjuree(
              fontSize: 17.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

class InfoIconOverlay extends StatefulWidget {
  @override
  _InfoIconOverlayState createState() => _InfoIconOverlayState();
}

class _InfoIconOverlayState extends State<InfoIconOverlay> {
  OverlayEntry? _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        height: 200,
        top: MediaQuery.of(context).size.height / 2 - 100,
        left: MediaQuery.of(context).size.width / 2 - 150,
        child: Material(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Glossary',
                            style: GoogleFonts.baiJamjuree(
                              fontSize: 17.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close,
                                color: AppColors.white, size: 15),
                            onPressed: () => _overlayEntry?.remove(),
                          ),
                        ],
                      ),
                      // SizedBox(height: 20),
                      Text(
                        'Artist : Avery Robinson',
                        style: GoogleFonts.baiJamjuree(
                          fontSize: 17.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Director : Karl Anton',
                        style: GoogleFonts.baiJamjuree(
                          fontSize: 17.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     TextButton(
              //       onPressed: () => _overlayEntry?.remove(),
              //       child: const Text('Close'),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline, size: 30),
      onPressed: () => _showOverlay(context),
    );
  }
}
