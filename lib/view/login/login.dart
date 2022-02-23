import 'package:expense_dev/controller/login_store.dart';
import 'package:expense_dev/theme/cores.dart';
import 'package:expense_dev/theme/entrada_texto.dart';
import 'package:expense_dev/view/main/principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoginStore store = LoginStore();
    return Form(
      key: formKey,
      child: Scaffold(
        body: Observer(
          builder: (_) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  const SizedBox(height: 25),
                  const Center(
                    child: Text(
                      'Olá! Seja bem-vindo!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: Text(
                      'Não perca nenhuma novidade!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  EntradaTexto(
                    controler: store.email,
                    texto: 'E-mail',
                    tipo: TextInputType.emailAddress,
                    onchanged: (String value) {
                      store.validarEmail(value);
                    },
                    validacao: (value) {
                      if (!store.emailValido) {
                        return 'Informe um e-mail válido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 35),
                  EntradaTexto.senha(
                    controler: store.senha,
                    texto: 'Senha',
                    onchanged: (String value) {
                      store.validarSenha(value);
                    },
                    validacao: (value) {
                      if (!store.senhaValida) {
                        return 'Informe uma senha válida (8 letras e caracteres especiais).';
                      } else {
                        return null;
                      }
                    },
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Cores.rosa),
                      onPressed: () async {
                        formKey.currentState?.validate();
                        if (store.isValidarAcesso) {
                          await store.retornarLogin();
                          store.inLogin
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Principal(),
                                  ),
                                )
                              : null;
                        }
                      },
                      child: store.inLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : const Text(
                              'ENTRAR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(height: 2, color: Colors.grey)),
                        const Text('    Ou continue com    '),
                        Flexible(
                            flex: 1,
                            child: Container(height: 2, color: Colors.grey)),
                      ],
                    ),
                  ),
                  //Icones das redes sociais
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 35),
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: SvgPicture.asset(
                          'images/google.svg',
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 35),
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: SvgPicture.asset(
                          'images/apple.svg',
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 35),
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: SvgPicture.asset(
                          'images/facebook.svg',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Não é membro? '),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Registre-se agora',
                  style: TextStyle(
                    color: Cores.rosa,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
