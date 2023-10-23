import 'package:desire_car/pages/cars_list.dart';
import 'package:desire_car/utils/animation_transition.dart';
import 'package:desire_car/utils/constants.dart';
import 'package:desire_car/models/car.dart';
import 'package:desire_car/scrapper/details.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_remixicon/flutter_remixicon.dart';

class CarDetail extends StatefulWidget {
  final Car selectedCar;
  const CarDetail(this.selectedCar);
  @override
  _CarDetailState createState() => _CarDetailState();
}

// List<Map> colors = [
//   {
//     "name": "black",
//     "color": Colors.black,
//     "asset": "assets/carbig-black.png",
//   },
//   {
//     "name": "green",
//     "color": Colors.green,
//     "asset": "assets/carbig-green.png",
//   },
//   {
//     "name": "grey",
//     "color": Colors.grey,
//     "asset": "assets/carbig-grey.png",
//   },
//   {
//     "name": "purple",
//     "color": Colors.purple,
//     "asset": "assets/carbig-purple.png",
//   },
//   {
//     "name": "red",
//     "color": Colors.red,
//     "asset": "assets/carbig.png",
//   },
// ];

class _CarDetailState extends State<CarDetail> {
//     with SingleTickerProviderStateMixin {
//   // Animation setups
//   late AnimationController animationController;
//   late Animation animation;
//   List<AnimationItem> animationItems = [];

//   // Keep track of selected car index;
//   int selectedIndex = 0;
//   // setup animations
//   @override
//   final details;
//   void initState() {}
// details=fetchDetails(uri)
//     animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 700));
//     for (int i = 0; i < 10; i++) {
//       animationItems.add(
//         AnimationItem(
//           id: "slide-${i + 1}",
//           entry: 30 * (i + 1),
//           entryDuration: 250,
//           visible: false,
//         ),
//       );
//     }
//     animation = Tween<double>(begin: 0, end: 300).animate(animationController)
//       ..addListener(() {
//         setState(() {
//           animationItems = updateVisibleState(
//             animationItems,
//             animation.value,
//           );
//         });
//       });
//     animationController.forward();
//     super.initState();
//   }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0XFFF4F4FF,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: kToolbarHeight,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              animateTransition(context, CarsList());
                            },
                            child: Container(
                              height: 55.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              child: const Icon(Icons.keyboard_backspace),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 55.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              child: const Icon(Icons.menu
                                  // MIcon.riMenu2Line,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.selectedCar.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                                color: Color(0xFF333333),
                              ),
                            ),
                            TextSpan(
                              text: "Starts from \$201,967",
                              style: TextStyle(
                                height: 1.7,
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                        // Lets create a list of all car image colors
                        child: Align(
                          alignment: Alignment.center,
                          child: widget.selectedCar.image,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 360.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            _getTabItem("Inspire", true),
                            const SizedBox(
                              width: 15.0,
                            ),
                            _getTabItem("Inform", false),
                            const SizedBox(
                              width: 15.0,
                            ),
                            _getTabItem("Technical Data", false),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Hello there, thank you for coming here, please dont forget to subscribe and like this video if you learnt something from it",
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 16.0,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Divider(),
                      const SizedBox(height: 15.0),
                      // Row(
                      //   children: colors.map((color) {
                      //     int index = colors.indexOf(color);
                      //     return GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           // Change selected index
                      //           selectedIndex = index;
                      //         });
                      //       },
                      //       child: Container(
                      //         height: 35.0,
                      //         width: 35.0,
                      //         margin: const EdgeInsets.only(
                      //           right: 10.0,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: color["color"],
                      //           shape: BoxShape.circle,
                      //           border: Border.all(
                      //             width: 4.0,
                      //             color: index == selectedIndex
                      //                 ? kPrimaryColor
                      //                 : Colors.transparent,
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[400]!,
                              ),
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                            ),
                            child: const Icon(Icons.heart_broken
                                // FlutterIcons.heart_fea,
                                ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 22.0,
                                  ),
                                  child: Text(
                                    "Checkout",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _getTabItem(String text, bool isActive) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          color:
              isActive ? const Color(0xFF333333) : Colors.black.withOpacity(.5),
          fontSize: isActive ? 18.0 : 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      isActive
          ? Container(
              margin: const EdgeInsets.only(top: 5.0),
              height: 4.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: isActive ? kPrimaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
            )
          : const SizedBox.shrink()
    ],
  );
}
