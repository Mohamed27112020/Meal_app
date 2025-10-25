import 'package:flutter/material.dart';
import 'package:meal_app/Views/NavHome.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingWithBackground extends StatefulWidget {
  const OnboardingWithBackground({super.key});

  @override
  _OnboardingWithBackgroundState createState() =>
      _OnboardingWithBackgroundState();
}

class _OnboardingWithBackgroundState extends State<OnboardingWithBackground> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      //     'image': 'assets/p2.jpg',
      'title': 'Welcome to Our App',
      'description': 'Discover amazing features designed just for you',
      'color': Colors.blue.withOpacity(0.6),
    },
    {
      //     'image': 'assets/p2.jpg',
      'title': 'Easy to Use',
      'description': 'Simple interface that gets you started quickly',
      'color': Colors.purple.withOpacity(0.6),
    },
    {
      //     'image': 'assets/p2.jpg',
      'title': 'Get Started',
      'description': 'Join thousands of satisfied users today',
      'color': Colors.green.withOpacity(0.6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/p2.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),

          Positioned(
            //     width: 400,
            //    height: 400,
            bottom: 150,
            left: 50,
            right: 50,
            child: Container(
              width: 350,
              height: 450,
              //   color: Colors.,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (_, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _pages[index]['title'],
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  _pages[index]['description'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // Page Indicator
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: _pages.length,
                        effect: const WormEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.white54,
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child:
                _currentIndex == _pages.length - 1
                    ? ElevatedButton(
                      onPressed:
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    )
                    : FloatingActionButton(
                      onPressed:
                          () => _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                    ),
          ),
          // Skip Button
          if (_currentIndex != _pages.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ),
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
