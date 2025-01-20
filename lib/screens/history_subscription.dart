import 'package:flutter/material.dart';

class HistorySubscription extends StatefulWidget {
  const HistorySubscription({super.key});

  @override
  State<HistorySubscription> createState() => _HistorySubscriptionState();
}

class _HistorySubscriptionState extends State<HistorySubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [Text("History Subscription")],
        ),
      ),
    );
  }
}
