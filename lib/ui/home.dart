import 'package:cash_flow_project/controller/cash_flow_controller.dart';
import 'package:cash_flow_project/ui/line_flow_widget.dart';
import 'package:cash_flow_project/ui/new_entry_flow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  CashFlowController _cashFlowController;

  @override
  void initState() {
    _cashFlowController = CashFlowController();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await _cashFlowController.getCashFlowList();
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cashFlowController.cashFlowList != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "PROJETO: MEU ALUGUEL / PLEYCE - Valores em CAD",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Balanço: ${_cashFlowController.total}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: _cashFlowController.cashFlowList.length,
                      itemBuilder: (context, index) {
                        var item = _cashFlowController.cashFlowList[index];

                        return Dismissible(
                            key: Key(item.id.toString()),
                            background: Container(color: Colors.red),
                            child: Column(children: [
                              LineFlowWidget(item),
                              Divider(height: 1.5)
                            ]),
                            onDismissed: (direction) async {
                              await _cashFlowController.delete(item.id);
                              await _cashFlowController.getCashFlowList();
                              setState(() {});
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("'${item.description}' apagado"),
                                ),
                              );
                            });
                      }),
                )
              ],
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlow,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addFlow() async {
    var newEntry = await showDialog(
      context: context,
      builder: (context) => NewEntryFlowWidget(_cashFlowController),
    );

    if (newEntry != null) {
      await _cashFlowController.getCashFlowList();
      setState(() {});
    }
  }
}
