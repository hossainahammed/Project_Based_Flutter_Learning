import 'package:flutter/material.dart';

class Flag_Card extends StatelessWidget {
  final String title;
  final String subtitle;
  final String flagUrl;

  const Flag_Card({
    super.key,
    required this.title,
    required this.subtitle,
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

       children: [
          // Flag image with fixed height
         // Inside children of Column
         Stack(
           children: [
             ClipRRect(
               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
               child: Image.asset(
                 flagUrl,
                 fit: BoxFit.cover,
                 height: 100,
                 width: double.infinity,
               ),
             ),
             Positioned(
               bottom: 3,
               left: 6,
               child: _buildBadge('Batch 10'),
             ),
             Positioned(
               bottom: 3,
               right: 6,
               child: _buildBadge('6 seats left'),
             ),
           ],
         ),


         // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const Spacer(), // Pushes the button to the bottom
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.arrow_forward, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Explore',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}
