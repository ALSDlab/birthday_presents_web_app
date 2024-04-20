import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회사소개'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('회사 이미지1'),
              Text('BRAND STORY'),
            ],
          )
        ],
      ),
    );
  }
}
