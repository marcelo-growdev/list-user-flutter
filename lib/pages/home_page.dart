import 'package:flutter/material.dart';
import 'package:formulario_cadastro/db/db.dart';
import 'package:formulario_cadastro/entidades/usuario.dart';
import 'package:formulario_cadastro/repositories/usuario_repository.dart';

import '../routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsuarioRepository usuarioRepository;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _mostrarSnackBar(String mensagem) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          mensagem,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _excluirUsuario(int id) async {
    bool result = await usuarioRepository.excluirUsuario(id);
    if (result) {
      setState(() {});
      _mostrarSnackBar('Usuário excluido com sucesso!');
    }
  }

  @override
  void initState() {
    super.initState();
    usuarioRepository = UsuarioRepository(DB());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: usuarioRepository.getUsuarios(),
        initialData: [],
        builder: (ctx, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            //padding: const EdgeInsets.only(top: 10),
            itemBuilder: (ctx, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.gravatar.com/avatar/$index/?d=robohash'),
                  ),
                  title: Text('${snapshot.data[index].nome}'),
                  subtitle: Text('${snapshot.data[index].email}'),
                  trailing: PopupMenuButton(onSelected: (int value) {
                    switch (value) {
                      case 2:
                        print('Editar');
                        break;
                      case 3:
                        print('Excluindo...');
                        _excluirUsuario(snapshot.data[index].id);
                        break;
                      default:
                        print('Visualizar');
                        break;
                    }
                  }, itemBuilder: (ctx) {
                    return [
                      PopupMenuItem(
                        child: Text('Visualizar'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Editar'),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text('Excluir'),
                        value: 3,
                      ),
                    ];
                  }),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var user =
              await Navigator.of(context).pushNamed(AppRoutes.FORMULARIO_PAGE);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
