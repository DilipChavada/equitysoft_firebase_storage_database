import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_container.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_appbar.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/screen/product_screen/product_list_screen.dart';
import 'package:flutter/material.dart';

import '../strings.dart';
import 'category_screen/category_screen.dart';
import 'company_screen/company_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar.customAppBar(context, appBarTitle:Strings.home,
          isArrowVisible: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                      CustomContainer.customContainer(context,text:Strings.product,
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
                        },
                      ),
                       const SizedBox(height:10),
                       CustomContainer.customContainer(context,text:Strings.category,
                       onTap: () {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const CategoryScreen()));
                       },),
                      const SizedBox(height:10),
                      CustomContainer.customContainer(context,text:Strings.company,
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => const CompanyScreen()));
                      },),

                ],
              ),
            ),
          )
      ),
    );
  }
}