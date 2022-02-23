import 'package:flutter/material.dart';

import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/compras_model.dart';
import 'package:expense_dev/theme/cores.dart';
import 'package:intl/intl.dart';

class Compras extends StatefulWidget {
  final String userId;
  const Compras({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  Databasepadrao banco = Databasepadrao.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fotos compradas',
          style: TextStyle(
            color: Cores.azulEscuro,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: banco.retornarCompras(widget.userId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ComprasDetalhesModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map(
                          (e) => ListTile(
                            leading: SizedBox(
                              height: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: e.thumbnailUrl != null
                                    ? Image.network(e.thumbnailUrl!)
                                    : null,
                              ),
                            ),
                            title: Text('${e.albumTitle}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${e.url}'),
                                Text(formatter
                                    .format(double.parse(e.valor.toString()))),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
