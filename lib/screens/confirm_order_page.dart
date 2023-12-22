import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmate/data/api.dart';
import 'package:pharmate/data/medicine.dart';
import 'package:pharmate/data/pharmacy.dart';
import 'package:pharmate/widgets/rounded_background_rectangle.dart';
import 'package:pharmate/widgets/set_number_items.dart';

class ConfirmOrderPage extends StatelessWidget {
  final Medicine item;
  final Pharmacy pharmacy;
  final int maxAvailQuantity;
  static int _numItems = 1;
  final TextEditingController controller = TextEditingController();

  ConfirmOrderPage(
      {super.key,
      required this.item,
      required this.pharmacy,
      required this.maxAvailQuantity});

  // Used to get value from child widget.
  // No state management package was used in order not to over-engineer.
  callBack(int num) {
    _numItems = num;
  }

  @override
  Widget build(BuildContext context) {
    final bool accessibleNavigation =
        MediaQuery.of(context).accessibleNavigation;
    return Scaffold(
        body: ListView(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Riepilogo Ordine",
            semanticsLabel: "Riepilogo del tuo ordine di seguito",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 50,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const ExcludeSemantics(
          child: SizedBox(height: 40),
        ),
        SizedBox(
          height: 300,
          child: RoundedBackgroundRectangle(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: ExcludeSemantics(
                    child: Text("Prodotto:"),
                  )),
              ListTile(
                title: Text(
                  item.nome,
                  semanticsLabel: "Stai ordinato il prodotto: ${item.nome}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                trailing: Visibility(
                  visible: accessibleNavigation ? false : true,
                  child: SizedBox(
                    width: 120,
                    child: SetNumberItems(
                      callBack: callBack,
                      maxQuantity: maxAvailQuantity,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: ExcludeSemantics(
                  child: Text("Farmacia:"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  pharmacy.nome,
                  semanticsLabel: "Stai ordinando dalla farmacia ${pharmacy.nome}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Visibility(
                    visible: accessibleNavigation ? true : false,
                    child: Semantics(
                        label: "Inserisci il numero di prodotti da ordinare",
                        child: TextField(
                          maxLength: 2,
                          controller: controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ))),
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff023D74),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      var data = {
                        'aic': item.codice_aic,
                        'codice_farmacia': pharmacy.codice_farmacia,
                        'qt': accessibleNavigation ? controller.text : _numItems,
                      };
                      await CallApi()
                          .postData(data, 'ordine')
                          .then((isSuccess) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text('Esito ordine'),
                                  content: Text((isSuccess)
                                      ? "Ordine confermato"
                                      : "Ops, qualcosa è andato storto.\nRiprova più tardi."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      });
                    },
                    child: const Text(
                      "Conferma Ordine",
                    )),
              )
            ],
          )),
        ),
      ],
    ));
  }
}
