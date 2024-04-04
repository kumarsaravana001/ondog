import 'package:flutter/material.dart';

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
                  padding: EdgeInsets.all(20),
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Overlay Container',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Text('This is a container appearing over the screen.',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () => _overlayEntry?.remove(),
                    child: Text('Close'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info_outline, size: 30),
      onPressed: () => _showOverlay(context),
    );
  }
}
