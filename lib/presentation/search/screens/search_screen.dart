import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:forui/forui.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: const FHeader(
        title: Text('Search'),
      ),
      content: Column(
        children: [
          CupertinoSearchTextField(
            onChanged: (value) {
              // TODO: Implement search
            },
          ),
          24.heightBox,
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Text('Item $index'),
            ),
          ),
        ],
      ),
    );
  }
}
