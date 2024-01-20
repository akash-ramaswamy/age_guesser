import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _controller = PageController(viewportFraction: 0.5);
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: SafeArea(bottom: false, child: Container()),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: Text(
                      'Age',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned(
                              top: constraints.maxHeight * 0.209,
                              left: constraints.maxWidth * 0.345,
                              child: Container(
                                alignment: Alignment.center,
                                width: constraints.maxHeight * 0.50,
                                height: constraints.maxHeight * 0.50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              left: constraints.maxWidth * 0.1,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.center,
                                width: constraints.maxHeight * 0.90,
                                height: constraints.maxHeight * 0.90,
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
                                    itemCount: 10,
                                    scrollDirection: Axis.vertical,
                                    physics: ClampingScrollPhysics(),
                                    controller: _controller,
                                    pageSnapping: true,
                                    onPageChanged: (index) => setState(
                                      () => _index = index,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Text(
                                          '${index + 10}',
                                          style: GoogleFonts.notoSerif(
                                            fontSize:
                                                _index == index ? 120 : 110,
                                            fontWeight: FontWeight.bold,
                                            color: _index == index
                                                ? Colors.black
                                                : Colors.black38,
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 2,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            color: kPrimaryColor,
                            strokeWidth: 5,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'guessing your age'.toUpperCase(),
                            style: GoogleFonts.notoSans(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                  _controller.animateToPage(
                                    _index + 3,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                },
                                // change border radius
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Above'.toUpperCase(),
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
                                  _controller.animateToPage(
                                    _index - 3,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                },
                                // change border radius
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8),
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
                                  _controller.animateToPage(
                                    _index - 3,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                },
                                // change border radius
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Below'.toUpperCase(),
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
