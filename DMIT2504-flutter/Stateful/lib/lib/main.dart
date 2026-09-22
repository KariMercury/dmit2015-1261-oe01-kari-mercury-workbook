import 'package:flutter/material.dart';

import 'steps/step0_start.dart';
import 'steps/step1_widget_style.dart';
import 'steps/step2_app_theme.dart';
import 'steps/step3_fonts.dart';

/// DMIT 2504 – Week 3 Day 2 – Themes and Styling
///
/// Live-demo entry point. Change [demoStep] and hot-restart to jump between
/// the stages of the demo:
///
///   0 – Starting point: profile page, no theming, hard-coded styles
///   1 – Style ONE widget: custom values, then Theme.of(context)
///   2 – App-wide theme: ThemeData, ColorScheme.fromSeed, light/dark, copyWith
///   3 – Fonts: app-wide font family + a different font on one widget
const int demoStep = 0;

void main() {
  runApp(switch (demoStep) {
    0 => const Step0App(),
    1 => const Step1App(),
    2 => const Step2App(),
    _ => const Step3App(),
  });
}
