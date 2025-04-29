import 'package:flutter/material.dart';

class FooterBar extends StatelessWidget {
  FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Image.network(
                '2wCEAAkGBxIQEhUQEBMTFRAWEBEXGRYVEhgdFxIVFhYWFhoXFRYYHiggGBslGxkWITEhJSkrLi4uFyA1ODMtNygtLisBCgoKDg0OGxAQGy0mICYvLS0vLS0tLS8tLSsvLS0tLi0tLS0rLS0tLS0rLS0vLS0tLS0tLS0tLS0tLS0tLS0tLf',
              ),
              TextButton(
                onPressed: () {
                  print('sd');
                },
                child: Text('Hi Vivek 234!'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
