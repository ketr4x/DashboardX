import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
            title,
            style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Go to Settings',
            onPressed: () {
              //TODO: navigate to settings page
            },
        ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Please choose the scooter you want to connect to...',
                  style: TextStyle(fontSize: 16),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
