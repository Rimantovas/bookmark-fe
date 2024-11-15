import 'package:flutter/cupertino.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search'),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoSearchTextField(
              onChanged: (value) {
                // TODO: Implement search
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ),
        ],
      ),
    );
  }
}
