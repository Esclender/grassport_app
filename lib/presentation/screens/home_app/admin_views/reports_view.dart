import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report View'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Carousel of Cards
          Expanded(
            child: SingleChildScrollView(
              child: CarouselSlider(
                options: CarouselOptions(height: 200.0),
                items: [
                  CardWidget('Card 1',
                      () => _showCardDetails(context, 'Card 1 Details')),
                  CardWidget('Card 2',
                      () => _showCardDetails(context, 'Card 2 Details')),
                  CardWidget('Card 3',
                      () => _showCardDetails(context, 'Card 3 Details')),
                ],
              ),
            ),
          ),
          // Detailed View
          Expanded(
            child: Center(
              child: Text('Selected Card Details'),
            ),
          ),
        ],
      ),
    );
  }

  void _showCardDetails(BuildContext context, String details) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(details),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CardWidget(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}
