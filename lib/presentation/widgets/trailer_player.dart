import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class YouTubeIframeScreen extends StatefulWidget {
  final String videoUrl;

  // Constructor to accept videoUrl
  YouTubeIframeScreen({required this.videoUrl});

  @override
  State<YouTubeIframeScreen> createState() => _IframeScreenState();
}

class _IframeScreenState extends State<YouTubeIframeScreen> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    _iFrameElement.style.height = '50%';
    _iFrameElement.style.width = '50%';
    _iFrameElement.src = widget.videoUrl;

    _iFrameElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iFrameElement,
    );

    super.initState();
  }

  final Widget _iframeWidget = HtmlElementView(
    ///creates the widget which is show the pdf which is registered
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _iframeWidget,
        ),
      ),
    );
  }
}
