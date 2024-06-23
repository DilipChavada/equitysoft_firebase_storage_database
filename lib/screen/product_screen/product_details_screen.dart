import 'dart:developer';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_container.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/screen/product_screen/add_edit_product_screen.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/screen/product_screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import '../../custom_appbar.dart';
import '../../custom_textstyles.dart';
import '../../gen/colors.gen.dart';
import '../../services/database.dart';
import '../../strings.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productName,
    required this.price,
    required this.category,
    required this.companyName,
    required this.qty,
    required this.description,
    required this.id,
    required this.imageList,
  });

  final String productName;
  final String price;
  final String category;
  final String companyName;
  final String qty;
  final String description;
  final String id;
  final List imageList;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar.customAppBar(
            context,
            appBarTitle: Strings.productDetails,
            onTapArrow: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductListScreen()),
              );
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorName.blackColor.withOpacity(0.25),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: ColorName.whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: widget.imageList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          clipBehavior: Clip.hardEdge,
                          child:Image.file(widget.imageList[index],fit: BoxFit.cover),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.productName,
                        style: CustomTextStyles.textStyle14(context)
                            .copyWith(fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        Text("${Strings.price} :",
                            style: CustomTextStyles.textStyle14(context)
                                .copyWith(fontWeight: FontWeight.w500)),
                        Text(widget.price,
                            style: CustomTextStyles.textStyle14(context)),
                      ],
                    )
                  ],
                ),
                Text(widget.category,
                    style: CustomTextStyles.textStyle9(context)),
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.companyName,
                          style: CustomTextStyles.textStyle14(context)
                              .copyWith(fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("${Strings.qty}:",
                              style: CustomTextStyles.textStyle14(context)
                                  .copyWith(fontWeight: FontWeight.w500)),
                          Text(widget.qty,
                              style: CustomTextStyles.textStyle14(context)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text("${Strings.description}:",
                    style: CustomTextStyles.textStyle14(context)
                        .copyWith(fontWeight: FontWeight.w500)),
                Text(widget.description,
                    style: CustomTextStyles.textStyle14(context)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContainer.customContainer(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.20,
                      textStyle: CustomTextStyles.textStyle14(context)
                          .copyWith(color: ColorName.whiteColor),
                      context,
                      text: Strings.edit,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditProductScreen(
                                      isEdit: true,
                                      id: widget.id,
                                      description: widget.description,
                                      price: widget.price,
                                      productName: widget.productName,
                                      qty: widget.qty,
                                      category: widget.category,
                                      companyName: widget.companyName,
                                      imageList: widget.imageList,
                                    )));
                      },
                    ),
                    CustomContainer.customContainer(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.20,
                        textStyle: CustomTextStyles.textStyle14(context)
                            .copyWith(color: ColorName.whiteColor),
                        context,
                        text: Strings.delete, onTap: () async {
                      try {
                        log("widget.id::${widget.id}");
                        await Database.deleteProduct(widget.id)
                            .then((value) => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text("Record Deleted success"))))
                            .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListScreen())));
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          log(e.toString());
                        }
                      }
                    }),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
