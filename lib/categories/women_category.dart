import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/utilities/cat_list.dart';
import 'package:multi_store_app/minor_screens/sub_categoryproduct.dart';

import '../widgets/category_widgets.dart';

class WomenCategory extends StatelessWidget {
  const WomenCategory({super.key});

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
                    headerlabel: 'Women',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 14,
                      crossAxisCount: 3,
                      children: List.generate(women.length-1, (index) {
                        return SubCategoryModel(
                          subCategoryName: women[index+1],
                          subCateglabel: women[index+1],
                          assetName: 'images/women/women$index.jpg',
                          mainCategoryName: 'women',
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
              mainCategName: 'women',
            ),
          ),
        ],
      ),
    );
  }
}
