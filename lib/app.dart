import 'package:flutter/material.dart';
import './posts/view/view.dart';


class InfiniteApp extends MaterialApp{
  const InfiniteApp({super.key}):super(
    debugShowCheckedModeBanner: false,
    home:const PostPage()
  );
}