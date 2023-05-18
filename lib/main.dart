import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinitelistapp/simple_bloc_observer.dart';
import 'app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(App());
}
