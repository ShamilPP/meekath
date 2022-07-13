import 'package:baitulmaal/view/animations/slide_in_widget.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String name;
  final String subText;
  final Color subColor;
  final void Function()? onTap;
  final String suffixText;

  const MyListTile({
    Key? key,
    required this.name,
    required this.subText,
    this.subColor = Colors.black,
    required this.onTap,
    this.suffixText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SlideInWidget(
                      delay: 100,
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SlideInWidget(
                      delay: 300,
                      child: Text(
                        subText,
                        style: TextStyle(fontSize: 15, color: subColor),
                      ),
                    ),
                  ],
                ),
                SlideInWidget(child: Text(suffixText))
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
