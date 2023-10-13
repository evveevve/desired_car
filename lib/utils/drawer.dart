import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:desire_car/pages/compare.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    List<Shadow>? shadow;
    return Drawer(
      backgroundColor: Color(0xFFE4E4EE),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: kPrimaryColor,
              ),
            ),
          ),
          const DrawerHeader(
            child: CircleAvatar(
              radius: 50,
              foregroundImage: AssetImage('assets/91521848.jpg'),
            ),
          ),
          InkWell(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: () {},
            onHover: (b) {
              b
                  ? shadow = [
                      Shadow(
                        color: Colors.purple[100]!,
                      ),
                    ]
                  : null;
            },
            child: Text(
              'Home',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  shadows: shadow),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Compare()));
            },
            onHover: (b) {
              b
                  ? shadow = [
                      Shadow(
                        color: Colors.purple[100]!,
                      ),
                    ]
                  : null;
            },
            child: Text(
              'Compare Car',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  shadows: shadow),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
