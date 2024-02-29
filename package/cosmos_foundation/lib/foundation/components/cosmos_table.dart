import 'package:flutter/material.dart';

class CosmosTable<TSample> extends StatelessWidget {
  final List<String> headers;

  final List<TSample> samples;

  final bool isLoading;

  final Widget Function(String header) buildHeaderCell;

  final Widget Function()? onEmpty;

  const CosmosTable({
    super.key,
    this.samples = const <Never>[],
    this.isLoading = false,
    this.onEmpty,
    required this.buildHeaderCell,
    required this.headers,
  });

  @override
  Widget build(BuildContext context) {
    assert(headers.isNotEmpty, 'Table headers mustn\'t be empty');

    return LayoutBuilder(
      builder: (_, BoxConstraints constrains) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constrains.maxWidth,
                  ),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          for (String header in headers)
                            buildHeaderCell(
                              header,
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: (samples.isEmpty && (onEmpty != null)),
                  child: onEmpty!.call(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
