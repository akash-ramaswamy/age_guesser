import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const Color kPrimaryColor = Color(0xFFC2E0E3);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Guesser',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _index = 63;
  final List<int> _ages = List.generate(100, (index) => index + 1);
  bool _isCorrect = false;

  final PageController _controller = PageController(
    viewportFraction: 0.5,
    initialPage: 63,
  );

  int guess = 63 + 1;
  int _lastAbove = 0;
  int _lastBelow = 0;
  final maxGuesses = 6;
  int _guesses = 0;
  final List<Color> guessColors = [
    const Color(0xFF3E777B),
    const Color(0xFFFFD700),
    const Color(0xFFFFA500),
    const Color(0xFFFF6347),
    const Color(0xFFFF4500),
    const Color(0xFF8B0000),
  ];

  calculateGuessesAsPercentage() {
    return (_guesses / maxGuesses) * 100;
  }

  calculateNextGuess(isAbove) {
    if (isAbove) {
      print("current guess: $guess is lower");
      _lastAbove = guess;
    } else {
      print("current guess: $guess is higher");
      _lastBelow = guess;
    }

    guess = ((_lastAbove + _lastBelow) / 2).floor();
    print("next guess: $guess");
    _guesses++;
  }

  reset() {
    guess = 63 + 1;
    _lastAbove = 0;
    _lastBelow = 0;
    _isCorrect = false;

    _controller.animateToPage(
      guess - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      'Age Guesser',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double width = min(constraints.maxHeight * 0.935, 400);

                        return Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.25,
                              left: MediaQuery.of(context).size.width * 0.12,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                alignment: Alignment.center,
                                width: width - 190,
                                height: width - 190,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              left: constraints.maxWidth * 0.12,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                ),
                                child: SizedBox(
                                  height: double.infinity, // Card height
                                  child: PageView.builder(
                                    itemCount: _ages.length,
                                    scrollDirection: Axis.vertical,
                                    physics: const ClampingScrollPhysics(),
                                    controller: _controller,
                                    pageSnapping: true,
                                    onPageChanged: (index) => setState(
                                      () {
                                        _index = index;
                                        HapticFeedback.lightImpact();
                                      },
                                    ),
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Text(
                                          '${_ages[index]}',
                                          style: GoogleFonts.notoSerif(
                                            fontSize:
                                                _index == index ? 120 : 110,
                                            fontWeight: FontWeight.bold,
                                            color: _index == index
                                                ? Colors.black
                                                : const Color(0xFFC3E0E3),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          child: LinearProgressIndicator(
                            minHeight: 6,
                            backgroundColor: kPrimaryColor,
                            color: guessColors[_guesses == 0 ? 0 : _guesses - 1],
                            borderRadius: BorderRadius.circular(10),
                            value: calculateGuessesAsPercentage() / 100,
                            semanticsLabel: 'Linear progress indicator',
                          ),
                        ),
                        Text(
                          'is your age'.toUpperCase(),
                          style: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 8,
                    //   ),
                    //   child: Text(
                    //     'your age is'.toUpperCase(),
                    //     style: GoogleFonts.notoSans(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  calculateNextGuess(true);
                                  _controller.animateToPage(
                                    guess - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                },
                                // change border radius
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Above ${_index + 1} ?".toUpperCase(),
                                  style: GoogleFonts.notoSans(
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isCorrect = true;
                                    reset();
                                  });
                                },
                                // change border radius
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  backgroundColor: kPrimaryColor,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'correct'.toUpperCase(),
                                  style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  calculateNextGuess(false);
                                  _controller.animateToPage(
                                    guess - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                },
                                // change border radius
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(18),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Below ${_index + 1} ?".toUpperCase(),
                                  style: GoogleFonts.notoSans(
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
