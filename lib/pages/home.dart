import 'dart:math';
import 'package:desire_car/scrapper/brands.dart';
import 'package:desire_car/scrapper/data.dart';
import 'package:desire_car/models/animation_item.dart';
import 'package:desire_car/utils/constants.dart';
import 'package:desire_car/utils/drawer.dart';
import 'package:desire_car/widgets/car_modal.dart';
import 'package:desire_car/widgets/fade_slide.dart';
import 'package:desire_car/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

const Y_OFFSET = 60.0;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Page controller
  late PageController pageController;
  // Keep track of active page 4 as default (almost middle)
  double pageScrollValue = 4.0;
  // active Page index
  int activePage = 4;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  //  Animation controller and animation

  late AnimationController animationController;
  late Animation animation;

  // Define all items we want to animate

  List<AnimationItem> animationItems = [
    // First text
    AnimationItem(
      id: "slide-1",
      entry: 100,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-2",
      entry: 150,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-3",
      entry: 160,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-4",
      entry: 180,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-5",
      entry: 200,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-6",
      entry: 190,
      entryDuration: 400,
      visible: false,
    ),
    AnimationItem(
      id: "slide-7",
      entry: 210,
      entryDuration: 400,
      visible: false,
    ),
  ];

  late Map<String, dynamic> selected;
  List? brandLogo;
  @override
  void initState() {
    () async {
      brands = await fetchBrands();
      // print(brands);
      if (brands!['error'] == 'no error') {
        brandLogo = brands!['data'];
        // print(brandLogo);
        setState(() {});
      }
    }();
    pageController = PageController(
      initialPage: 4,
      // wont take up whole page
      viewportFraction: .55,
    )..addListener(() {
        // Forgot to update state
        setState(() {
          activePage = pageController.page!.round();
          pageScrollValue = pageController.page as double;
        });
      });

    //  initialize animation controller
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // initialize animation
    animation = Tween<double>(begin: 0, end: 210).animate(animationController)
      ..addListener(() {
        // We cant see anything because we are not updating UI
        // and animation state
        setState(() {
          animationItems = updateVisibleState(animationItems, animation.value);
        });
      });

    // Play animation
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // clear animations
    animationController.dispose();
    // clear page controller
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lets restart the app so icons can load
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const SideDrawer(),
      body: brandLogo == null
          ? Center(
              child: Image.asset(
                'assets/car_cloud.png',
              ),
            )
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Lets slide animated this
                    FadeSlide(
                      direction: getItemVisibility("slide-1", animationItems),
                      offsetX: 0.0,
                      offsetY: Y_OFFSET,
                      duration: getSlideDuration("slide-1", animationItems),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Dream Car",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.0,
                              color: kPrimaryColor,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              scaffoldKey.currentState?.openEndDrawer();
                            },
                            icon: const Icon(Icons.menu, color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    FadeSlide(
                      direction: getItemVisibility("slide-2", animationItems),
                      offsetX: 0.0,
                      offsetY: Y_OFFSET,
                      duration: getSlideDuration("slide-2", animationItems),
                      child: const Text(
                        "Discover Your\nDream Car",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FadeSlide(
                      direction: getItemVisibility("slide-3", animationItems),
                      offsetX: 0.0,
                      offsetY: Y_OFFSET,
                      duration: getSlideDuration("slide-3", animationItems),
                      child: const Text(
                        'Explore a Wide Range of Cars, Evaluate Electric Options, and Compare to Make the Perfect Choice',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Flexible(
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        itemBuilder: (BuildContext context, int index) {
                          // print(brandLogo?[index]['imageSrc']);
                          if (index.toDouble() == pageScrollValue) {
                            selected = brands?['data'][index];
                          }

                          return Align(
                            alignment: Alignment.center,
                            child: Stack(
                              // We need to animate sizes on scroll here
                              // #1 Entry animation
                              alignment: Alignment.topRight,
                              children: [
                                ScaleAnimation(
                                  direction: getItemVisibility(
                                      "slide-4", animationItems),
                                  duration: getSlideDuration(
                                      "slide-4", animationItems),
                                  // Lets now animate scrolling
                                  child: AnimatedContainer(
                                    padding: const EdgeInsets.all(20.0),
                                    duration: const Duration(milliseconds: 300),
                                    height: activePage == index ? 180.0 : 120.0,
                                    width: activePage == index ? 180.0 : 120.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          Color(0xFFE4E4EE),
                                          Color.fromARGB(130, 228, 228, 238),
                                          Color.fromARGB(118, 228, 228, 238),
                                          Color.fromARGB(69, 228, 228, 238)
                                        ],
                                        stops: [.6, .8, .85, .9],
                                      ),
                                      // color: Color(0xFFE4E4EE),
                                    ),
                                    child: Transform.scale(
                                      scale: max(
                                        .5,
                                        1.0 - (pageScrollValue - index).abs(),
                                      ),
                                      child: ClipOval(
                                        child: Image.network(brandLogo?[index]
                                            ['imageSrc'] as String),
                                      ),
                                    ),
                                  ),
                                ),
                                // Lets delay this
                                Positioned(
                                  top: 10.0,
                                  right: 10.0,
                                  child: ScaleAnimation(
                                    duration: getSlideDuration(
                                        "slide-6", animationItems),
                                    direction: getItemVisibility(
                                        "slide-6", animationItems),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      child: index.toDouble() == pageScrollValue
                                          ? Container(
                                              width: 30.0,
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                color: kPrimaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: brandLogo?.length,
                      ),
                    ),
                    FadeSlide(
                      direction: getItemVisibility("slide-5", animationItems),
                      offsetX: 0.0,
                      offsetY: Y_OFFSET,
                      duration: getSlideDuration("slide-5", animationItems),
                      child: Text(
                        "Swipe left or right to see more",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FadeSlide(
                      offsetX: 0.0,
                      offsetY: Y_OFFSET,
                      duration: getSlideDuration("slide-7", animationItems),
                      direction: getItemVisibility("slide-7", animationItems),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .7,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Show bottom sheet on click
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                ),
                              ),
                              barrierColor: Colors.black.withOpacity(.8),
                              context: context,
                              builder: (_) {
                                return CarModal(selected);
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 22.0),
                            child: Text(
                              "Continue",
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
              ),
            ),
    );
  }
}
