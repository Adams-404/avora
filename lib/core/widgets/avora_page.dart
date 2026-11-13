import 'package:flutter/material.dart';

import '../../core/theme/avora_spacing.dart';

/// Shared page frame: a centred, width-limited column with the standard
/// page padding.
///
/// The shell owns safe areas and navigation. Keeping the frame here means every
/// destination scrolls identically and tablet or desktop windows do not stretch
/// text to the edges.
class AvoraPage extends StatelessWidget {
  const AvoraPage({super.key, required this.children});

  final List<Widget> children;

  static const double _maxContentWidth = 640;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AvoraSpacing.lg,
            AvoraSpacing.xl,
            AvoraSpacing.lg,
            AvoraSpacing.xxl,
          ),
          children: children,
        ),
      ),
    );
  }
}
