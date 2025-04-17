import 'package:flutter/material.dart';

// Example of a reusable widget if needed
class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  const CustomLoadingIndicator({super.key, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        // Could be a CircularProgressIndicator or a custom animation
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
