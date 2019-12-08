import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CashFlowModel {
  
  int id;
  double price;
  String description;
  DateTime creationDate;

  String get formattedPrice => price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
  String get formattedCreationDate => DateFormat("d MMM yy").add_jm().format(creationDate);

  CashFlowModel({@required this.price, @required this.description, @required this.creationDate});

  CashFlowModel.fromDb(Map<String, dynamic> row) {
    id = row["id"];
    price = row["price"];
    description = row["description"];
    creationDate = DateTime.parse(row["creation_date"]);
  }

}