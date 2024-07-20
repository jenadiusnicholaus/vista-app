import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

loader() {
  return Builder(builder: (context) {
    return SpinKitWave(
      color: Theme.of(context).primaryColor,
      size: 20.0,
    );
  });
}
