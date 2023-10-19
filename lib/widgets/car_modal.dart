import 'package:desire_car/models/animation_item.dart';
import 'package:desire_car/models/car.dart';
import 'package:desire_car/pages/cars_list.dart';
import 'package:desire_car/scrapper/data.dart';
import 'package:desire_car/scrapper/products.dart';
import 'package:desire_car/utils/animation_transition.dart';
import 'package:desire_car/utils/constants.dart';
import 'package:desire_car/widgets/fade_slide.dart';
import 'package:flutter/material.dart';

class CarModal extends StatefulWidget {
  const CarModal(this.selectedBrand);
  final Map<String, dynamic> selectedBrand;
  @override
  _CarModalState createState() => _CarModalState();
}

// Lets model our cars
// List<Car> cars = [
//   Car(
//     image: Image.asset(
//       "assets/car3.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   Car(
//     image: Image.asset(
//       "assets/carbig.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   Car(
//     image: Image.asset(
//       "assets/car4.png",
//       width: 100.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   Car(
//     image: Image.asset(
//       "assets/car1.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   // Duplicate
//   Car(
//     image: Image.asset(
//       "assets/car3.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   Car(
//     image: Image.asset(
//       "assets/carbig.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   Car(
//     image: Image.asset(
//       "assets/car4.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
//   Car(
//     image: Image.asset(
//       "assets/car1.png",
//       width: 150.0,
//     ),
//     name: "BMW Series 3",
//     stock: 6,
//   ),
// ];

class _CarModalState extends State<CarModal>
    with SingleTickerProviderStateMixin {
  late List<AnimationItem> animationItems = [
    // AnimationItem(
    //   id: "slide-1",
    //   entry: 30,
    //   entryDuration: 300,
    //   visible: false,
    // ),
    // AnimationItem(
    //   id: "slide-2",
    //   entry: 30,
    //   entryDuration: 300,
    //   visible: false,
    // ),
    // AnimationItem(
    //   id: "slide-3",
    //   entry: 35,
    //   entryDuration: 300,
    //   visible: false,
    // ),
    ...List.generate(
      cars!.length,
      (index) => AnimationItem(
        id: "slide-$index",
        entry: 30 + (index),
        entryDuration: 300,
        visible: false,
      ),
    ),
    // AnimationItem(
    //   id: "slide-12",
    //   entry: 64,
    //   entryDuration: 300,
    //   visible: false,
    // ),
  ];
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    () async {
      products = await fetchProducts(widget.selectedBrand['brandHref']);
      if (products!['error'] == 'no error') {
        cars = [
          ...products!['data'].map(
            (item) {
              print(item);
              return Car(
                  image: Image.network(
                    item['car image'],
                    width: 150.0,
                  ),
                  name: item['car name'],
                  variants: item['total versions']);
            },
          )
        ];
        //   'car name': item['car name'],
        //   'car image': item['car image'],
        //   'variants': item['total versions'],
        // } as Map<String, String>)
        setState(() {});
      }
    }();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 64).animate(animationController)
      ..addListener(() {
        setState(() {
          animationItems = updateVisibleState(animationItems, animation.value);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return cars == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 520.0,
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                FadeSlide(
                  offsetX: 0.0,
                  offsetY: 150.0,
                  duration: getSlideDuration("slide-1", animationItems),
                  child: Image.network(
                    widget.selectedBrand['imageSrc'],
                    width: 50.0,
                  ),
                  direction: !getItemVisibility("slide-1", animationItems),
                ),
                SizedBox(height: 8.0),
                FadeSlide(
                  offsetX: 0.0,
                  offsetY: 150.0,
                  duration: getSlideDuration("slide-2", animationItems),
                  child: Text(
                    widget.selectedBrand['brandName'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27.0,
                    ),
                  ),
                  direction: !getItemVisibility("slide-2", animationItems),
                ),
                FadeSlide(
                  offsetX: 0.0,
                  offsetY: 150.0,
                  duration: getSlideDuration("slide-3", animationItems),
                  child: Text(
                    "${cars!.length} Series",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  direction: !getItemVisibility("slide-3", animationItems),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200.0,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // We also want to animate this on [View All] click
                      return
                          //  FadeSlide(
                          //   offsetX: 0.0,
                          //   offsetY: 150.0,
                          //   // SLides 4 to 11
                          //   direction: !getItemVisibility(
                          //       "slide-${cars!.length}", animationItems),
                          //   duration: getSlideDuration(
                          //       "slide-${cars!.length}", animationItems),
                          //   child: Container(
                          //     child:
                          Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: 130.0,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFE4E4EE),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: cars![index].image,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            cars![index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            "${cars![index].variants} variants",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                        // ),
                        // ),
                      );
                    },
                    // separatorBuilder: (BuildContext context, int index) {
                    //   return SizedBox(
                    //     width: 20.0,
                    //   );
                    // },
                    itemCount: cars!.length,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                // We will also animate this
                FadeSlide(
                  offsetX: 0.0,
                  offsetY: 150.0,
                  direction: !getItemVisibility("slide-12", animationItems),
                  duration: getSlideDuration("slide-12", animationItems),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // Trigger animation play on view all click
                        await animationController.forward();
                        // We then need to change page route
                        // Lets create an animated router and the page
                        // We want to navigate to
                        animateTransition(context, CarsList());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 22.0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
