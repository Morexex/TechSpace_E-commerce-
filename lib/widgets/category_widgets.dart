import 'package:flutter/material.dart';

import '../minor_screens/sub_categoryproduct.dart';

class SliderBar extends StatelessWidget {
  final String mainCategName;
  const SliderBar({
    super.key,
    required this.mainCategName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50)),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCategName == 'beauty'
                    ? const Text('')
                    : const Text(
                        ' << ',
                        style: style,
                      ),
                Text(
                  mainCategName.toUpperCase(),
                  style: style,
                ),
                mainCategName == 'men'
                    ? const Text('')
                    : const Text(
                        ' >> ',
                        style: style,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
    color: Colors.brown,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 10);

class SubCategoryModel extends StatelessWidget {
  final String mainCategoryName;
  final String subCategoryName;
  final String assetName;
  final String subCateglabel;
  const SubCategoryModel({
    super.key,
    required this.mainCategoryName,
    required this.subCategoryName,
    required this.assetName,
    required this.subCateglabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubcategProducts(
                      mainCategName: mainCategoryName,
                      subCategName: subCategoryName,
                    )));
      },
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image(image: AssetImage(assetName)),
          ),
          Text(
            subCateglabel,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class CategoryHeaderLabel extends StatelessWidget {
  final String headerlabel;
  const CategoryHeaderLabel({
    super.key,
    required this.headerlabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerlabel,
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }
}
