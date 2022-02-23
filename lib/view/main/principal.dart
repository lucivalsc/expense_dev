import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/albuns_model.dart';
import 'package:expense_dev/controller/albuns_store.dart';
import 'package:expense_dev/theme/cores.dart';
import 'package:expense_dev/view/albuns/album_list.dart';
import 'package:expense_dev/view/compras/compras.dart';
import 'package:expense_dev/view/login/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<Principal> {
  AlbunsStore albunsStore = AlbunsStore();
  Databasepadrao banco = Databasepadrao.instance;

  List<Map> lista = [];

  Future lerDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    albunsStore.emailLogado = prefs.getString('email') ?? '';
    albunsStore.nomeLogado = prefs.getString('name') ?? '';
    albunsStore.idLogado = prefs.getString('id') ?? '';
  }

  @override
  void initState() {
    super.initState();
    lerDados();
    albunsStore.retornarAlbuns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinza,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const SplashWidget(),
          ),
        ),
        child: const Icon(Icons.logout),
        backgroundColor: Cores.azulEscuro,
      ),
      body: Observer(
        builder: (_) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        lista = await banco.retornarUser();
                        _showUserDetail();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Cores.azulEscuro,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Olá',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            albunsStore.nomeLogado,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Cores.azulEscuro,
                            ),
                          ),
                          Text(
                            albunsStore.emailLogado,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                Compras(userId: albunsStore.idLogado),
                          ),
                        );
                      },
                      child: Lottie.asset(
                        'images/bell2.json',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                albunsStore.inLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: FutureBuilder(
                          future: banco.retornarAlbuns(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<AlbunsModel>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView(
                                children: snapshot.data!
                                    .map(
                                      (e) => ListTile(
                                        onTap: () async {
                                          final retorno = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AlbumList(albuns: e),
                                            ),
                                          );
                                          if (retorno == true) {
                                            setState(() {});
                                          }
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor: Cores.amarelo,
                                          child: Text('${e.id}'),
                                        ),
                                        title: Text('${e.title}'),
                                        trailing:
                                            const Icon(Icons.arrow_forward_ios),
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
          ),
        ),
      ),
    );
  }

  _showUserDetail() {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25),
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Cores.azulEscuro,
              ),
              child: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width * 0.3,
                color: Colors.white,
              ),
            ),
            Text(
              lista[0]['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Cores.azulEscuro,
              ),
            ),
            Text('Usuário: ' + lista[0]['username']),
            Text('E-mail: ' + lista[0]['email']),
            Text('Telefone: ' + lista[0]['phone']),
            Text('Site: ' + lista[0]['website']),
          ],
        );
      },
    );
  }
}
