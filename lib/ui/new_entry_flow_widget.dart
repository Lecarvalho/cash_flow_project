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

  bool showInvalidFieldsWarning = false;

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
          TextField(
            controller: _textEditingPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(helperText: "Preço", hintText: "CAD"),
          ),
          showInvalidFieldsWarning
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
          onPressed: () async {
            if (widget._cashFlowController.isValid(
              _textEditingDescriptionController.text,
              _textEditingPriceController.text,
            )) {
              await widget._cashFlowController.save(
                CashFlowModel(
                  creationDate: DateTime.now(),
                  description: _textEditingDescriptionController.text,
                  price: double.parse(
                      _textEditingPriceController.text.replaceAll(",", ".")),
                ),
              );

              Navigator.pop(context, true);
            } else {
              setState(() {
                showInvalidFieldsWarning = true;
              });
            }
          },
          child: Text("OK"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("FECHAR"),
        )
      ],
    );
  }
}
