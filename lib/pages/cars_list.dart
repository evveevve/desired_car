import 'package:desire_car/models/animation_item.dart';
import 'package:desire_car/pages/car_detail.dart';
import 'package:desire_car/pages/home.dart';
import 'package:desire_car/utils/animation_transition.dart';
import 'package:desire_car/scrapper/data.dart';
import 'package:desire_car/widgets/fade_slide.dart';
import 'package:flutter/material.dart';

class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EEF6),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: SizedBox.shrink(),
              ),
              // Lets make setups for animations
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Home(),
                        ),
                      );
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
                  const Text(
                    "Panda",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/panda.jpg",
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                "Choose your\nawesome car!",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                  color: Color(0xFF333333),
                  height: 1.3,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 20.0,
                    ),
                    height: 190.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Create CarDetail()
                        animateTransition(context, CarDetail(cars![index]));
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: cars![index].image,
                            ),
                          ),
                          Text(
                            cars![index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "${cars![index].variants} variants",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
                // referencing the cars from car_modal.dart
                itemCount: cars!.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
