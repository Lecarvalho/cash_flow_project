import 'package:cash_flow_project/model/cash_flow_model.dart';
import 'package:cash_flow_project/repository/cash_flow_dao.dart';

class CashFlowController {
  List<CashFlowModel> cashFlowList;
  double get _total =>
      cashFlowList != null ? cashFlowList.fold(0, (a, b) => a + b.price) : 0.0;

  String get total =>
      _total.toStringAsFixed(_total.truncateToDouble() == _total ? 0 : 2);

  CashFlowDAO _dao = CashFlowDAO();

  Future<void> getCashFlowList() async {
    cashFlowList = await _dao.getList();
  }

  Future<void> save(CashFlowModel cashFlow) async {
    await _dao.insert(cashFlow);
  }

  Future<void> delete(int id) async {
    await _dao.delete(id);
  }

  bool isValid(String description, String price) {
    return description != null &&
        description.isNotEmpty &&
        price != null &&
        price.isNotEmpty &&
        double.tryParse(price.replaceAll(",", ".")) != null;
  }
}
