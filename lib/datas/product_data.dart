import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;
  String category;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    price = snapshot.data["price"]+0.0;
    description = snapshot.data["description"];
    images = snapshot.data["image"];
    sizes = snapshot.data["sizes"];
  }

}