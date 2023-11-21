import 'package:flutter/material.dart';
import 'package:liquid_example/core/routes.dart';

AppBar appBar(BuildContext context) => AppBar(
      title: Text(routes.entries.elementAt(index % routes.length).value.$2),
      actions: [
        IconButton(
            onPressed: () {
              prev();
              Navigator.of(context).pushReplacementNamed(routes.entries.elementAt(index % routes.length).key);
            },
            icon: const Icon(Icons.arrow_back)),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () {
              next();
              Navigator.of(context).pushReplacementNamed(routes.entries.elementAt(index % routes.length).key);
            },
            icon: const Icon(Icons.arrow_forward)),
      ],
    );

class Called {
  static int count = 0;
}
