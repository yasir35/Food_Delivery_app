import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel> search = [];

  void productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productUnit: element.get("productUnit"), productQuantity: element.get("productQuantity"),
    );
    if (productModel != null) {
      search.add(productModel!);
    }
  }

  /////////////// herbsProduct ///////////////////////////////
  List<ProductModel> herbsProductList = [];

  Future<void> fatchHerbsProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        if (productModel != null) {
          newList.add(productModel!);
        }
      },
    );
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  //////////////// Fresh Product ///////////////////////////////////////
  List<ProductModel> freshProductList = [];

  Future<void> fatchFreshProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        if (productModel != null) {
          newList.add(productModel!);
        }
      },
    );
    freshProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }

  //////////////// Root Product ///////////////////////////////////////
  List<ProductModel> rootProductList = [];

  Future<void> fatchRootProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("RootProduct").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        if (productModel != null) {
          newList.add(productModel!);
        }
      },
    );
    rootProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return rootProductList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}
