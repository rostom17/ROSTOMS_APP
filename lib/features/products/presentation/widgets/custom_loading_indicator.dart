import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, required this.isLoadingMore});

  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Center(
        child: isLoadingMore
            ? const CircularProgressIndicator.adaptive()
            : const SizedBox.shrink(),
      ),
    );
  }
}
