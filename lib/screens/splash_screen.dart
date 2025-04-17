import 'dart:async';
import 'package:black_ants_app/config/app_constants.dart';
import 'package:black_ants_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // For random tagline

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late String _currentTagline;

  final List<String> _displayEmojis = [];
  Timer? _emojiTimer;

  @override
  void initState() {
    super.initState();

    _currentTagline = AppConstants.taglines[Random().nextInt(AppConstants.taglines.length)];

    // Fade Animation Controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    // Progress Bar Animation Controller
    _progressController = AnimationController(
       duration: const Duration(seconds: 4), // Total duration for splash
       vsync: this,
    );
     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_progressController)
      ..addListener(() {
         setState(() {}); // Trigger rebuild to update progress bar
       });

    // Emoji appearance Timer
     _startEmojiAnimation();

    // Start animations
    _fadeController.forward();
    _progressController.forward();


    // Navigate after a delay slightly shorter than progress animation
    Timer(const Duration(milliseconds: 4200), () {
      if (mounted) { // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

 void _startEmojiAnimation() {
   int emojiIndex = 0;
   _emojiTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
     if (emojiIndex < AppConstants.splashEmojis.length) {
        if (mounted) {
         setState(() {
           _displayEmojis.add(AppConstants.splashEmojis[emojiIndex]);
         });
         emojiIndex++;
        } else {
           timer.cancel(); // Stop if widget is disposed
        }
     } else {
       timer.cancel();
     }
   });
 }


  @override
  void dispose() {
    _fadeController.dispose();
    _progressController.dispose();
    _emojiTimer?.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppConstants.appName,
                style: textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 48, // Larger App Name
                   shadows: [
                     Shadow(
                       blurRadius: 10.0,
                       color: theme.colorScheme.primary.withOpacity(0.5),
                       offset: const Offset(0, 0),
                     ),
                   ]
                ),
              ),
              const SizedBox(height: 40), // Spacing

              // Animated Emojis - Appealing Grid/Row Wrap
               AnimatedSize( // Smooth size transition as emojis are added
                 duration: const Duration(milliseconds: 200),
                 curve: Curves.easeInOut,
                 child: Wrap(
                   spacing: 15.0, // Horizontal space
                   runSpacing: 10.0, // Vertical space
                   alignment: WrapAlignment.center,
                   children: _displayEmojis.map((emoji) => Text(
                     emoji,
                     style: const TextStyle(fontSize: 28), // Emoji size
                   )).toList(),
                 ),
               ),

              const SizedBox(height: 40), // Spacing

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Save', style: textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('•', style: TextStyle(color: theme.colorScheme.primary, fontSize: 20)),
                  ),
                  Text('Trade', style: textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground)),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('•', style: TextStyle(color: theme.colorScheme.primary, fontSize: 20)),
                  ),
                  Text('Invest', style: textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground)),
                ],
              ),

              const SizedBox(height: 25), // Spacing

              Text(
                _currentTagline,
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 60), // Spacing

              // Fancy Loading Indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progressAnimation.value,
                    minHeight: 8, // Make it thicker
                    backgroundColor: AppConstants.greyText.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
