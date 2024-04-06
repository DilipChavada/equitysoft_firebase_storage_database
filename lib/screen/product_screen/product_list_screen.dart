import 'dart:developer';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_container.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_textstyles.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/screen/home_screen.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/screen/product_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import '../../custom_appbar.dart';
import '../../gen/colors.gen.dart';
import '../../services/database.dart';
import '../../strings.dart';
import 'add_edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar.customAppBar(context,
              appBarTitle: Strings.productList,
              isAddVisible: true, onTapArrow: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }, onTapAdd: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditProductScreen()),
            );
          }),
          body: StreamBuilder(
              stream: Database.getAllProduct(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(snapshot.error.toString())));
                } else if (snapshot.hasData) {
                  if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var docs = snapshot.data!.docs[index];
                        //var allDataList=snapshot.data!.docs.map((e) => e.data()).toList();
                       // log("All Data List :: $allDataList");
                       // List imageDataList = snapshot.data!.docs.map((e) => e.data()["image_url"]).toList();
                        //log("Image Data List :: $imageDataList");
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                            id: docs["id"],
                                            productName: docs["product_name"],
                                            price: docs["price"],
                                            category: docs["category"],
                                            companyName: docs["company_name"],
                                            qty: docs["qty"],
                                            description: docs["description"],
                                            imageUrl: docs["image_url"],
                                          )));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: ColorName.whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorName.blackColor
                                          .withOpacity(0.25),
                                      offset: const Offset(0, 3),
                                      blurRadius: 6,
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    crossAxisCount: 2),
                                            itemCount: docs["image_url"].length,
                                            itemBuilder: (context, imageIndex) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                clipBehavior: Clip.hardEdge,
                                                child: Image.network(
                                                    docs["image_url"]
                                                        [imageIndex],
                                                    fit: BoxFit.cover),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("${docs["product_name"]}",
                                                style: CustomTextStyles
                                                    .textStyle14(context)),
                                            Text(
                                              "${docs["category"]}",
                                              style:
                                                  CustomTextStyles.textStyle9(
                                                      context),
                                            ),
                                            Text(
                                              "Qty : ${docs["qty"]}",
                                              style:
                                                  CustomTextStyles.textStyle10(
                                                      context),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomContainer.customContainer(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
                                          textStyle: CustomTextStyles
                                                  .textStyle14(context)
                                              .copyWith(
                                                  color: ColorName.whiteColor),
                                          context,
                                          text: Strings.edit,
                                          onTap: () {
                                            Database.getSingleProductDetails(
                                              context,
                                              id: docs["id"],
                                              description: docs["description"],
                                              price: docs["price"],
                                              productName: docs["product_name"],
                                              qty: docs["qty"],
                                              category: docs["category"],
                                              companyName: docs["company_name"],
                                              // imageUrl:docs["image_url"],
                                            );
                                          },
                                        ),
                                        CustomContainer.customContainer(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.20,
                                          textStyle: CustomTextStyles
                                                  .textStyle14(context)
                                              .copyWith(
                                                  color: ColorName.whiteColor),
                                          context,
                                          text: Strings.delete,
                                          onTap: () async {
                                            try {
                                              await Database.deleteProduct(
                                                docs["id"])
                                                  .then((value) =>
                                                  ScaffoldMessenger.of(
                                                      context).showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              "Record Deleted success")
                                                      ))).then((value) => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const ProductListScreen())));
                                            } catch (e) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            e.toString())));
                                                log(e.toString());
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(child: Center(child: Text("No Data")));
              })),
    );
  }
}
