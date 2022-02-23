import 'package:expense_dev/view/albuns/photos_detail.dart';
import 'package:flutter/material.dart';
import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/albuns_model.dart';
import 'package:expense_dev/model/photos_model.dart';
import 'package:expense_dev/controller/login_store.dart';
import 'package:expense_dev/theme/cores.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AlbumList extends StatefulWidget {
  final AlbunsModel albuns;
  const AlbumList({
    Key? key,
    required this.albuns,
  }) : super(key: key);
  @override
  State<AlbumList> createState() => _PhotoListState();
}

class _PhotoListState extends State<AlbumList> {
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  LoginStore store = LoginStore();
  Databasepadrao banco = Databasepadrao.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listagem de fotos',
          style: TextStyle(
            color: Cores.azulEscuro,
          ),
        ),
        actions: [
          InkWell(
            onTap: _showModalDelete,
            child: Lottie.asset(
              'images/delete.json',
              repeat: false,
            ),
          ),
        ],
      ),
      backgroundColor: Cores.cinza,
      body: Column(
        children: [
          Expanded(
            child: store.inLoading
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder(
                    future: banco.retornarPhotos(widget.albuns.id.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PhotosModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          children: snapshot.data!
                              .map(
                                (e) => ListTile(
                                  onTap: () async {
                                    final retorno = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotosDetail(
                                            photos: e, albuns: widget.albuns),
                                      ),
                                    );
                                    if (retorno == true) {
                                      setState(() {});
                                    }
                                  },
                                  leading: SizedBox(
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(e.thumbnailUrl!),
                                    ),
                                  ),
                                  title: Text('${e.title}'),
                                  subtitle: Text(
                                      'Valor: ${formatter.format(double.parse(e.valor!))}'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
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

  _showModalDelete() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir todo este album?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCELAR'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Cores.rosa,
              ),
              onPressed: () {
                Navigator.pop(context);
                banco.deletar(tabelaAlbuns, colunaAlbunsId, widget.albuns.id!);
                banco.deletar(
                    tabelaPhotos, colunaPhotosAlbumId, widget.albuns.id!);
                Navigator.pop(context, true);
              },
              child: const Text('EXCLUIR'),
            ),
          ],
        );
      },
    );
  }
}
