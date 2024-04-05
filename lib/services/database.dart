
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screen/product_screen/add_edit_product_screen.dart';

class Database {

  static Future<void> addProduct(Map<String, dynamic> addProduct,String id) async {
    return FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .set(addProduct);
  }
  static Future<void> updateProduct(Map<String, dynamic> updateProduct,String id) async {
    FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .update(updateProduct);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProduct() {
    return FirebaseFirestore.instance.collection("Product").orderBy("company_name",descending: true).snapshots();
  }

  static Future<void> deleteProduct(String id) async {
    FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .delete();
  }
  static getSingleProductDetails(BuildContext context,{
    required String id,
    required String price,
    required String qty,
    required String description,
    required String productName,
    required String category,
    required String companyName,
    //required List imageUrl,
  }){
    return Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AddEditProductScreen(
          isEdit: true,
          description: description,
          productName: productName,
          id: id,
          price: price,
          qty: qty,
          category: category,
          companyName: companyName,
           // imageList : imageUrl
        )));
  }

  static Future<void> addCategory(Map<String, dynamic> addCategory,String id) async {
    return FirebaseFirestore.instance
        .collection("Category")
        .doc(id)
        .set(addCategory);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategory() {
    return FirebaseFirestore.instance.collection("Category").orderBy("category_name",descending: true).snapshots();
  }

  static Future<void> deleteCategory(String id) async {
    FirebaseFirestore.instance
        .collection("Category")
        .doc(id)
        .delete();
  }

  static Future<void> addCompany(Map<String, dynamic> addCompany,String id) async {
    return FirebaseFirestore.instance
        .collection("Company")
        .doc(id)
        .set(addCompany);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCompany() {
    return FirebaseFirestore.instance.collection("Company").orderBy("company_name",descending: true).snapshots();
  }

  static Future<void> deleteCompany(String id) async {
    FirebaseFirestore.instance
        .collection("Company")
        .doc(id)
        .delete();
  }
}
