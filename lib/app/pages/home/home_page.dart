// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, unused_element, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore _homeStore = HomeStore();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homeStore.loadInfos();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Color(0xFF00796B),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (_) => ListView.builder(
                  itemCount: _homeStore.infos.length,
                  itemBuilder: (_, index) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: cardWidth,
                        margin: const EdgeInsets.all(10),
                        child: Card(
                          child: ListTile(
                            title: Text(_homeStore.infos[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => _editInfo(index),
                                  child: Icon(Icons.edit, color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () => _showDeleteDialog(index),
                                  child: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: screenWidth * 0.8,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Digite seu texto',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _homeStore.addInfo(_textController.text);
                          _textController.clear();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: _launchPrivacyPolicy,
                child: Text(
                  'Política de Privacidade',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editInfo(int index) {
    final TextEditingController _editController =
        TextEditingController(text: _homeStore.infos[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Texto'),
          content: TextField(
            controller: _editController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Digite o novo texto',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                _homeStore.editInfo(index, _editController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir'),
          content: Text('Você deseja excluir este item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                _homeStore.removeInfo(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchPrivacyPolicy() async {
    const url = 'https://www.google.com/';
    if (!await launch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir a URL.')),
      );
    }
  }
}
