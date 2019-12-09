import 'package:cash_flow_project/controller/cash_flow_controller.dart';
import 'package:cash_flow_project/model/cash_flow_model.dart';
import 'package:flutter/material.dart';

class NewEntryFlowWidget extends StatefulWidget {
  final CashFlowController _cashFlowController;

  NewEntryFlowWidget(this._cashFlowController);

  @override
  _NewEntryFlowWidgetState createState() => _NewEntryFlowWidgetState();
}

class _NewEntryFlowWidgetState extends State<NewEntryFlowWidget> {
  final TextEditingController _textEditingDescriptionController =
      TextEditingController();

  final TextEditingController _textEditingPriceController =
      TextEditingController();

  final TextEditingController _textEditingCalendarController =
      TextEditingController();

  bool _showInvalidFieldsWarning;

  DateTime _newFlowDate;

  @override
  void initState() {
    _newFlowDate = DateTime.now();
    _showInvalidFieldsWarning = false;
    _textEditingCalendarController.text =
        widget._cashFlowController.formatDate(_newFlowDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Nova entrada",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _textEditingDescriptionController,
            decoration: InputDecoration(helperText: "Descrição"),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 70,
                child: TextField(
                  controller: _textEditingPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(helperText: "CAD"),
                ),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  readOnly: true,
                  controller: _textEditingCalendarController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(helperText: "Data da operação"),
                  onTap: () => showDatePicker(
                          context: context,
                          firstDate: DateTime(2019),
                          initialDate: _newFlowDate,
                          lastDate: DateTime(2030))
                      .then((res) async {
                    if (res != null) {
                      _textEditingCalendarController.text =
                          widget._cashFlowController.formatDate(res);
                      _newFlowDate = res;
                    }
                  }),
                ),
              )
            ],
          ),
          _showInvalidFieldsWarning
              ? Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      "Valores inválidos.",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                )
              : Container()
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("FECHAR"),
        ),
        FlatButton(
          onPressed: () async {
            if (widget._cashFlowController.isValid(
              _textEditingDescriptionController.text,
              _textEditingPriceController.text,
            )) {
              await widget._cashFlowController.save(
                CashFlowModel(
                  creationDate: _newFlowDate,
                  description: _textEditingDescriptionController.text,
                  price: double.parse(
                      _textEditingPriceController.text.replaceAll(",", ".")),
                ),
              );

              Navigator.pop(context, true);
            } else {
              setState(() {
                _showInvalidFieldsWarning = true;
              });
            }
          },
          child: Text("OK"),
        )
      ],
    );
  }
}
