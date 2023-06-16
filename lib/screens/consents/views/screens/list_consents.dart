import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/screens/consents/repo/consents_repo.dart';

class ListConsentsScreen extends ConsumerStatefulWidget {
  const ListConsentsScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListConsentsScreenState();
}

class _ListConsentsScreenState extends ConsumerState<ListConsentsScreen> {
  @override
  Widget build(BuildContext context) {
    final consents = ref.watch(consentsProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: consents.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(consents[index].id!),
                        subtitle: Text(consents[index].status.toString()),
                      )))
        ],
      ),
    );
  }
}
