import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_customDropDownTextField.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/custom_textfield.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/screen/product_screen/product_list_screen.dart';
import 'package:equitysoft_add_update_delete_view_data_local_storage_database/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../custom_appbar.dart';
import '../../custom_container.dart';
import '../../gen/colors.gen.dart';
import '../../strings.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({
    super.key,
    this.isEdit = false,
    this.productName,
    this.category,
    this.companyName,
    this.description,
    this.price,
    this.qty,
    this.id,
    //this.imageList
  });

  final bool isEdit;
  final String? productName;
  final String? category;
  final String? companyName;
  final String? description;
  final String? price;
  final String? qty;
  final String? id;
  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final formKey = GlobalKey<FormState>();
  bool autoValidateMode = false;
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  final categoryController = SingleValueDropDownController();
  final companyNameController = SingleValueDropDownController();
  List<String> selectImageList = ["PlusIcon"];
  List<String> selectImageUrlList = [];
  String id = FirebaseFirestore.instance.collection('Product').doc().id;
  bool isReadOnly = false;
  bool isEnable = true;
  bool enableInteractiveSelection = true;

  initialEditData() {
    productNameController.text = widget.productName!;
    companyNameController.setDropDown(DropDownValueModel(
        name: widget.companyName!, value: widget.companyName!));
    categoryController.setDropDown(
        DropDownValueModel(name: widget.category!, value: widget.category!));
    descriptionController.text = widget.description!;
    priceController.text = widget.price!;
    qtyController.text = widget.qty!;
    //imageUrl=widget.imageList!;
    //imageFileList=widget.imageList!;
    //log("widget.imageList.toString() :: ${widget.imageList.toString()}");
    //log("imageURL:: $imageUrl");
    //log("ImageFileList:: $imageFileList");
  }

  @override
  initState() {
    widget.isEdit ? initialEditData() : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar.customAppBar(
            context,
            appBarTitle:
                widget.isEdit ? Strings.editProduct : Strings.addProduct,
            onTapArrow: isReadOnly
                ? () {
                    const SizedBox.shrink();
                  }
                : () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductListScreen()),
                    );
                  },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    CustomTextField.customTextField(
                      enableInteractiveSelection: enableInteractiveSelection,
                      readOnly: isReadOnly,
                      controller: productNameController,
                      keyboardType: TextInputType.name,
                      context,
                      hintText: Strings.productName,
                      labelText: Strings.productName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Strings.enterProductName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder(
                      stream: Database.getAllCategory(),
                      builder: (context, snapshot) {
                        List<DropDownValueModel> allCategoryList = [];
                        if (snapshot.data?.docs != null) {
                          for (var element in snapshot.data!.docs) {
                            allCategoryList.add(DropDownValueModel(
                                name: element["category_name"],
                                value: element["category_name"]));
                          }
                        }
                        return CustomDropDownTextField.customDropDownTextField(
                            isEnabled: isEnable,
                            controller: categoryController, validator: (value) {
                          if (value!.isEmpty) {
                            return Strings.selectCategory;
                          }
                          return null;
                        }, onChanged: (value) {
                          log("select category :: $value");
                        }, context,
                            hintText: Strings.category,
                            labelText: Strings.category,
                            dropDownList: allCategoryList.map((i) {
                              return DropDownValueModel(
                                name: i.name,
                                value: i.value,
                              );
                            }).toList());
                      },
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder(
                      stream: Database.getAllCompany(),
                      builder: (context, snapshot) {
                        List<DropDownValueModel> allCompanyList = [];
                        if (snapshot.data?.docs != null) {
                          for (var element in snapshot.data!.docs) {
                            allCompanyList.add(DropDownValueModel(
                                name: element["company_name"],
                                value: element["company_name"]));
                          }
                        }
                        return CustomDropDownTextField.customDropDownTextField(
                          isEnabled: isEnable,
                          controller: companyNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Strings.selectCompanyName;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            log("select company name :: $value");
                          },
                          context,
                          hintText: Strings.companyName,
                          labelText: Strings.companyName,
                          dropDownList: allCompanyList.map((i) {
                            return DropDownValueModel(
                              value: i.name,
                              name: i.value,
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField.customTextField(
                      enableInteractiveSelection: enableInteractiveSelection,
                      readOnly: isReadOnly,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Strings.enterDescription;
                        }
                        return null;
                      },
                      controller: descriptionController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      context,
                      hintText: Strings.description,
                      labelText: Strings.description,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField.customTextField(
                      enableInteractiveSelection: enableInteractiveSelection,
                      readOnly: isReadOnly,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Strings.enterPrice;
                        }
                        return null;
                      },
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      context,
                      hintText: Strings.price,
                      labelText: Strings.price,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField.customTextField(
                      enableInteractiveSelection: enableInteractiveSelection,
                      readOnly: isReadOnly,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Strings.enterQty;
                        }
                        return null;
                      },
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      context,
                      hintText: Strings.qty,
                      labelText: Strings.qty,
                    ),
                    const SizedBox(height: 10),
                    widget.isEdit
                        ? GestureDetector(
                            onTap: () {
                              log("click");
                            },
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: selectImageList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  log("Selected Image Full Path :: ${selectImageList[index]}");
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: ColorName.greyBorderColor,
                                      ),
                                    ),
                                    child: Image.file(
                                      File(selectImageList[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: selectImageList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (BuildContext context, int index) {
                              log("Selected Image Full Path :: ${selectImageList[index]}");
                              return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isReadOnly
                                          ? ColorName.greyColor
                                          : ColorName.blackColor,
                                    ),
                                  ),
                                  child:
                                  selectImageList[index]=="PlusIcon"
                                      ? GestureDetector(
                                          onTap: isReadOnly
                                              ? () => const SizedBox.shrink()
                                              : () async {
                                                  selectMultipleImagePick();
                                                },
                                          child: Icon(Icons.add,
                                              size: 40,
                                              color: isReadOnly
                                                  ? ColorName.greyColor
                                                  : ColorName.blackColor))
                                      : Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            GestureDetector(
                                              onTap: isReadOnly
                                                  ? () =>
                                                      const SizedBox.shrink()
                                                  : () {
                                                      setState(() {
                                                        selectImageList
                                                            .removeAt(index);
                                                        log("Image Delete Success");
                                                        log("Delete Image selectImageList Length :: ${selectImageList.length - 1}");
                                                      });
                                                    },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Image.file(
                                                  height: MediaQuery.of(context).size.height,
                                                  width:MediaQuery.of(context).size.width,
                                                  File(selectImageList[index]),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                                offset: const Offset(15, -15),
                                                child: Icon(
                                                  size: 30,
                                                  Icons.delete,
                                                  color: isReadOnly
                                                      ? ColorName.greyColor
                                                      : ColorName.blackColor,
                                                )),
                                          ],
                                        ));
                            }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.isEdit
                            ? const Text("")
                            : selectImageList.length <= 2
                                ? const Text(
                                    "Select Minimum 2 Image Required",
                                  )
                                : const Text("")
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomContainer.customContainer(
                        height: MediaQuery.of(context).size.height * 0.08,
                        context,
                        text: widget.isEdit ? Strings.edit : Strings.save,
                        onTap: widget.isEdit
                            ? () async {
                                if (formKey.currentState!.validate()) {
                                  var product = {
                                    "product_name": productNameController.text,
                                    "category":
                                        categoryController.dropDownValue!.value,
                                    "company_name": companyNameController
                                        .dropDownValue!.value,
                                    "description": descriptionController.text,
                                    "price": priceController.text,
                                    "qty": qtyController.text,
                                    "id": widget.id,
                                    "image_url": selectImageUrlList
                                  };
                                  await uploadImageStorage().then((value) =>
                                      Database.updateProduct(
                                              product, widget.id!)
                                          .then((value) => ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Edit Product Success")))));
                                  productNameController.clear();
                                  descriptionController.clear();
                                  setState(() {
                                    categoryController.clearDropDown();
                                    companyNameController.clearDropDown();
                                  });
                                  priceController.clear();
                                  qtyController.clear();
                                  selectImageList.clear();
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductListScreen()));
                                  }
                                } else {
                                  setState(() {
                                    autoValidateMode = true;
                                  });
                                }
                              }
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  if (selectImageList.length > 2) {
                                    isEnable = false;
                                    isReadOnly = true;
                                    enableInteractiveSelection = false;
                                    var product = {
                                      "product_name":
                                          productNameController.text,
                                      "category": categoryController
                                          .dropDownValue!.value,
                                      "company_name": companyNameController
                                          .dropDownValue!.value,
                                      "description": descriptionController.text,
                                      "price": priceController.text,
                                      "qty": qtyController.text,
                                      "id": id,
                                      "image_url": selectImageUrlList,
                                    };
                                    await uploadImageStorage().then((value) {
                                      return Database.addProduct(product, id)
                                          .then((value) => ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Add Product Success"))));
                                    });
                                    productNameController.clear();
                                    descriptionController.clear();
                                    setState(() {
                                      categoryController.clearDropDown();
                                      companyNameController.clearDropDown();
                                    });
                                    priceController.clear();
                                    qtyController.clear();
                                    selectImageList.clear();
                                    if (context.mounted) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProductListScreen()));
                                    }
                                  } else {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Select Minimum 2 Image Required ::")));
                                      log("Select Minimum 2 Image Required ::");
                                    }
                                  }
                                } else {
                                  setState(() {
                                    autoValidateMode = true;
                                  });
                                }
                              }),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  selectMultipleImagePick() async {
    var pickerImages = await ImagePicker().pickMultiImage();
    if (selectImageList.length <= 1 && pickerImages.length < 2) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(" :: Select Minimum 2 Image Required")));
        log(" :: Select Minimum 2 Image Required");
      }
    } else {
        for (var pickImage in pickerImages) {
          log("selectImageList :: ${selectImageList.toList()}");
          log("pickImage.path :: ${pickImage.path}");
          if (selectImageList.contains(pickImage.path)) {
            setState(() {
              if (mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    const SnackBar(content: Text("Already Image")));
              }
            });
          }
          else {
            setState(() {
              selectImageList.insert(
                  selectImageList.length - 1,
                  pickImage.path
              );
            });
          }
          log("SelectedImage List Length :: ${selectImageList.length - 1}");
          log("SelectImage List :: ${selectImageList.toList()}");
        }
    }
  }
  Future uploadImageStorage() async {
    for (var imagePath in selectImageList) {
      try {
        if (File(imagePath).absolute.existsSync()) {
          //var ref = FirebaseStorage.instance.ref().child("images").child(imagePath);

          /*var ref = FirebaseStorage.instance.ref().child("images").child(DateTime.now().toString()).child(imagePath.toString().split("/").last);
          await ref.putFile(File(imagePath));
          selectImageUrlList.add(await ref.getDownloadURL());*/

          //var uploadTask = FirebaseStorage.instance.ref().child("images").child(imagePath).putFile(File(imagePath));

          var uploadTask = FirebaseStorage.instance
              .ref()
              .child("images")
              .child(id)
              .child(imagePath.toString().split("/").last)
              .putFile(File(imagePath.toString()));
          var streamSubscription = uploadTask.snapshotEvents.listen((event) {
            var per = event.bytesTransferred / event.totalBytes * 100;
            log("Percentage :: ${per.toString()}");
          });
          var taskSnapshot = await uploadTask;
          if (taskSnapshot.state == TaskState.success) {
            selectImageUrlList.add(await taskSnapshot.ref.getDownloadURL());
          }
          streamSubscription.cancel();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
          log(e.toString());
        }
      }
      log("uploadImageStorage () selectImageList Length :: ${selectImageList.length - 1}");
      log("selectImageList.toList() :: ${selectImageList.toList()}");
      setState(() {});
    }
  }
}
