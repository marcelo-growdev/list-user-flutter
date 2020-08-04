import 'package:formulario_cadastro/entidades/usuario.dart';
import 'package:formulario_cadastro/db/db.dart';

class UsuarioRepository {
  final DB _db;
  UsuarioRepository(this._db);

  Future<bool> saveUsuario(Usuario usuario) async {
    var intance = await _db.getInstance();

    var result = await intance.insert('users', usuario.toMap());

    return result > 0;
  }

  Future<bool> excluirUsuario(int id) async {
    var intance = await _db.getInstance();

    var result =
        await intance.delete('users', where: 'id = ?', whereArgs: [id]);

    return result > 0;
  }

  Future<List<Usuario>> getUsuarios() async {
    try {
      var instance = await _db.getInstance();

      var result = await instance.query('users');

      print(result);

      var usuarios = result.map((item) => Usuario.fromMap(item))?.toList();

      return usuarios ?? [];
    } catch (erro) {
      throw 'Erro ao buscar usuarios';
    }
  }
}
