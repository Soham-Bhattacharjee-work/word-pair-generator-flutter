import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordGenerator extends StatefulWidget {
  @override
  RandomWordGeneratorState createState() => RandomWordGeneratorState();
}

class RandomWordGeneratorState extends State<RandomWordGenerator> {
  final _randomWordPairs = <WordPair>[];
  final _savedWords = Set<WordPair>();
  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          //if (item.isOdd) return Divider();
          //final index = item ~/ 2;
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadysaved = _savedWords.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(alreadysaved ? Icons.favorite : Icons.favorite_border,
          color: alreadysaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadysaved) {
            _savedWords.remove(pair);
          } else {
            _savedWords.add(pair);
          }
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWords.map((WordPair pair) {
        return ListTile(
          title: Text(pair.asPascalCase),
        );
      });
      final List<Widget> savedlist =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
          appBar: AppBar(title: Text("Saved Words")),
          body: ListView(children: savedlist));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("WordPair Generator")),
        actions: <Widget>[
          IconButton(onPressed: pushSaved, icon: Icon(Icons.list))
        ],
      ),
      body: _buildList(),
    );
  }
}
