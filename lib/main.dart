


import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import './app.dart';
import './simple_bloc_observer.dart';

void main(){
  Bloc.observer = SimpleBlocObserver();
  runApp(const InfiniteApp());
}