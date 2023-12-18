// ignore_for_file: must_be_immutable, use_super_parameters, camel_case_types

import 'package:flutter/material.dart';

import '../Wellcome/Landingmodel.dart';
import '../Wellcome/LoginPage.dart';
import '../Wellcome/LoginPageNew.dart';

class landingpage extends StatefulWidget {
  const landingpage({super.key});

  @override
  State<landingpage> createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              onPageChanged: (value) => setState(() => currentIndex = value),
              itemCount: slides.length,
              itemBuilder: (context, index) {
                return Slider(
                  image: slides[index].getImage()!,
                  text: slides[index].getText()!,
                  description: slides[index].getDescription()!,
                );
              },
            ),
          ),
          Container(
            // width: 400,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              bottom: 80,
              left: 62,
              right: 62,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LandlordLogin()),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(width: 4, height: 0.0),
                        Icon(
                          Icons.skip_next,
                          color: Colors.purple,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => buildDot(index, context),
                  ),
                ),

                // Text('Hrlling,'),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  onTap: () => rightArrowHandler(context),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(width: 4, height: 0.0),
                        Icon(
                          // Icons.arrow_forward_rounded,
                          Icons.arrow_circle_right_outlined,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void rightArrowHandler(BuildContext context) {
    if (currentIndex == slides.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandlordLoginNew()),
      );
    }
    _controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

// container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.blue : Colors.black,
      ),
    );
  }
}

// slider declared
class Slider extends StatelessWidget {
  String? image;
  String? text;
  String? description;

  Slider({
    Key? key,
    this.image,
    this.text,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          // !(image!.contains("step"))
          // ?
          Image(
            height: 320,
            image: AssetImage(image!),
            fit: BoxFit.contain,
          ),
          // : Align(
          //     heightFactor: 0.74111,
          //     alignment: Alignment.center,
          //     child: Image(
          //       image: AssetImage(image!),
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          const SizedBox(height: 14),
          Text(
            text!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24,
            ),
            // textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          Text(
            description!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
