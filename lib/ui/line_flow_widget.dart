import 'package:cash_flow_project/model/cash_flow_model.dart';
import 'package:flutter/material.dart';

class LineFlowWidget extends StatelessWidget {
  final CashFlowModel cashFlowModel;
  LineFlowWidget(this.cashFlowModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 85,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            cashFlowModel.description,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                cashFlowModel.formattedCreationDate,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                cashFlowModel.formattedPrice,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                  color: cashFlowModel.price < 0 ? Colors.red : Color(0xFF4F4F4F)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
