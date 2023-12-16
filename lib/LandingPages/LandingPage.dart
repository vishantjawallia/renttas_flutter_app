// ignore_for_file: camel_case_types, use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import '../Wellcome/Landingmodel.dart';
import '../Wellcome/LoginPage.dart';

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
            child: //Text("SDds"),
            PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index) {
                //  return Text("data");
                  // contents of slider
                  return Slider(
                    image: slides[index].getImage()!,
                    text: slides[index].getText()!,
                    description: slides[index].getDescription()!,
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 60,
                  margin: const EdgeInsets.all(40),
                  width: 60,
                  // color: Colors.green,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LandlordLogin()),
                      );
                    },
                    icon: const Row(
                      children: [
                        Icon(
                          Icons.skip_next,
                          color: Colors.purple,
                          size: 42,
                        ),
                      ],
                    ),
                  )
                  // TextButton(
                  //   child: Text(
                  //       currentIndex == slides.length - 1 ? "Continue" : "Next"),
                  //   onPressed: () {
                  //
                  //   },
                  //   // textColor: Colors.white,
                  //   // shape: RoundedRectangleBorder(
                  //   // borderRadius: BorderRadius.circular(25),
                  //   // ),
                  // ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  slides.length,
                  (index) => buildDot(index, context),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 60,
                  margin: const EdgeInsets.all(40),
                  width: 40,
                  child: IconButton(
                    onPressed: () {
                      if (currentIndex == slides.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LandlordLogin()),
                        );
                      }
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn);
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.blue,
                      size: 42,
                    ),
                  )),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

// container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
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
  String? image, text, description;

  Slider({this.image, this.text, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // image given in slider
        SizedBox(height:250,child: Image(image: AssetImage(image!))),
        const SizedBox(
          height: 10,
        ),
        Text(
          text!,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description!,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
