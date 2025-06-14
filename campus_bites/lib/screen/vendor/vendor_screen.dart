import 'package:campus_bites/model/vendor.dart';
import 'package:flutter/material.dart';
//import 'package:campus_bites/providers.dart';

import 'package:campus_bites/screen/component/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorScreen extends ConsumerWidget {
  final Vendor? vendorObj;
  const VendorScreen({super.key, this.vendorObj});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Data
    final String imageUrl =
        vendorObj?.imageUrl ??
        'https://placehold.co/600x400/CCCCCC/FFFFFF?text=No+Image';
    //page
    return Scaffold(
      appBar: buildCustomAppBarVendor(),
      body:
          //--------------------image------------------------
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue, // to see whether background is there
                    image: DecorationImage(
                      image: NetworkImage(
                        imageUrl,
                      ), // Correct usage for network image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              //-------------tab view-----------------------
              const SizedBox(height: 10),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Menu'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        children: [
                          // Menu tab content
                          Center(child: Text('Menu Content')),
                          // Reviews tab content
                          Center(child: Text('Reviews Content')),
                        ],
                      ),
                    ),

                    //-------------every item view with add to cart button (dialog asking for quantity)-----------------------
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
// PrefferedSizeWidget build