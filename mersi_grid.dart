import 'package:flutter/material.dart';

class OrderGridPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const OrderGridPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.90, // safe ratio
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),

              itemBuilder: (context, index) {
                final item = items[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Top Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                        child: Image.network(
                          item["image"],
                          height: 105,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Order ID — wrapped text (safe)
                            Text(
                              item["id"],
                              maxLines: 2,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),

                            const SizedBox(height: 6),

                            /// Time
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.access_time, size: 15, color: Colors.red),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    item["time"],
                                    maxLines: 2,
                                    softWrap: true,
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            /// Rating
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < item["rating"]
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 15,
                                  color: Colors.red,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
