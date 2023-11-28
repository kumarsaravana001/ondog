import 'package:flutter/material.dart';

class ReelsFullScreen extends StatefulWidget {
  // final Widget image;
  const ReelsFullScreen({
    super.key,
  });

  @override
  State<ReelsFullScreen> createState() => _ReelsFullScreenState();
}

class _ReelsFullScreenState extends State<ReelsFullScreen> {
  @override
  Widget build(BuildContext context) {
   // final imageAsset = GoRouter.of(context).parameters['image'] as String?;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [Container()],
        ),
      ),
    );
  }
}
