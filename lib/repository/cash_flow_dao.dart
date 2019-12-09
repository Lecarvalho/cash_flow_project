import 'package:cash_flow_project/model/cash_flow_model.dart';
import 'package:cash_flow_project/repository/dbcontext.dart';
import 'package:sqflite/sqlite_api.dart';

class CashFlowDAO {
  Database database = DbContext().cashFlowDb;

  Future<List<CashFlowModel>> getList() async {
    var query = "SELECT id, price, description, creation_date FROM cash_flow";
    var rows = await database.rawQuery(query);

    if (rows != null) {
      return List.from(rows.map((row) => CashFlowModel.fromDb(row)));
    }

    return null;
  }

  Future<void> insert(CashFlowModel cashFlow) async {
    await database.insert("cash_flow", {
      "price": cashFlow.price,
      "description": cashFlow.description,
      "creation_date": cashFlow.creationDate.toString()
    });
  }

  Future<void> delete(int id) async {
    await database.delete("cash_flow", where: "id = $id");
  }

  Future<void> update(CashFlowModel cashFlow) async {
    await database.update(
        "cash_flow",
        {
          "price": cashFlow.price,
          "description": cashFlow.description,
          "creation_date": cashFlow.creationDate.toString()
        },
        where: "id = ${cashFlow.id}");
  }
}
