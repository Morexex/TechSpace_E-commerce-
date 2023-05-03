import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/utilities/cat_list.dart';


import '../widgets/category_widgets.dart';

class HomegardenCategory extends StatelessWidget {
  const HomegardenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryHeaderLabel(
                    headerlabel: 'Home & Garden',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 14,
                      crossAxisCount: 3,
                      children: List.generate(homegarden.length-1, (index) {
                        return SubCategoryModel(
                          subCategoryName: homegarden[index+1],
                          subCateglabel: homegarden[index+1],
                          assetName: 'images/homegarden/home$index.jpg',
                          mainCategoryName: 'homegarden',
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: SliderBar(
              mainCategName: 'homegarden',
            ),
          ),
        ],
      ),
    );
  }
}
