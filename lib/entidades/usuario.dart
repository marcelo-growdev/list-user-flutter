import 'package:formulario_cadastro/entidades/endereco.dart';

class Usuario {
  int id;
  String nome;
  String email;
  String cpf;
  String enderecoFormatado;
  Endereco endereco;

  Usuario() {
    endereco = Endereco();
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    cpf = map['cpf'];
    enderecoFormatado = map['endereco'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'cpf': cpf,
      'endereco': endereco.toString(),
    };
  }
}
