import 'package:flutter/material.dart';

class EntradaTexto extends StatelessWidget {
  final String? texto;
  final TextEditingController? controler;
  final bool? senha;
  final TextInputType? tipo;
  final String? Function(String?)? validacao;
  final Function(String)? onchanged;
  const EntradaTexto({
    Key? key,
    this.texto,
    this.controler,
    this.senha = false,
    this.tipo,
    this.validacao,
    this.onchanged,
  }) : super(key: key);
  const EntradaTexto.senha({
    Key? key,
    this.texto,
    this.controler,
    this.senha = true,
    this.tipo,
    this.validacao,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validacao,
      controller: controler,
      obscureText: senha!,
      keyboardType: tipo,
      onChanged: onchanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: texto,
      ),
    );
  }
}
