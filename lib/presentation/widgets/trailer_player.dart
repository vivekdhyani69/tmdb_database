import 'dart:html';
// import 'dart:ui' as ui;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class YouTubeIframeWidget extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String subtitle;
  final String viewType; // Ensure unique iframe registration

  const YouTubeIframeWidget({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.subtitle,
    required this.viewType,
  });

  @override
  State<YouTubeIframeWidget> createState() => _YouTubeIframeWidgetState();
}

class _YouTubeIframeWidgetState extends State<YouTubeIframeWidget> {
  late final IFrameElement _iFrameElement;

  @override
  void initState() {
    super.initState();

    _iFrameElement =
        IFrameElement()
          ..style.border = 'none'
          ..style.width = '400px'
          ..style.height = '300px'
          ..width = '400'
          ..height = '300'
          ..src = widget.videoUrl;

    // Register iframe with unique viewType
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.viewType,
      (int viewId) => _iFrameElement,
    );
  }

  @override
  void dispose() {
    _iFrameElement.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title :  ${widget.title}'),
          Text('Subtitle : ${widget.subtitle}'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300, maxWidth: 400),
              child: HtmlElementView(
                viewType: widget.viewType,
                key: UniqueKey(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
