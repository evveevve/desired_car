import 'package:desire_car/models/car.dart';
import 'package:desire_car/pages/cars_list.dart';
import 'package:desire_car/scrapper/data.dart';
import 'package:desire_car/scrapper/products.dart';
import 'package:desire_car/utils/animation_transition.dart';
import 'package:desire_car/utils/constants.dart';
import 'package:flutter/material.dart';

class CarModal extends StatefulWidget {
  const CarModal(this.selectedBrand);
  final Map<String, dynamic> selectedBrand;
  @override
  _CarModalState createState() => _CarModalState();
}

class _CarModalState extends State<CarModal>
     {
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

        setState(() {});
      }
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return cars == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 500.0,
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.0,
                ),

                Image.network(
                  widget.selectedBrand['imageSrc'],
                  width: 50.0,
                ),

                SizedBox(height: 8.0),

                Text(
                  widget.selectedBrand['brandName'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27.0,
                  ),
                ),

                Text(
                  "${cars!.length} Series",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200.0,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            width: 130.0,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE4E4EE),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: cars![index].image,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: 125,
                            child: Text(
                              cars![index].name,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
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
                      );
                    },
                    itemCount: cars!.length,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 20,
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextButton(
                    onPressed: () async {
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
                // )
              ],
            ),
          );
  }
}
