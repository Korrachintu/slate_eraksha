import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make scaffold transparent
      appBar: AppBar(
        title: const Text('Welcome Back!'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Quick Mood Analysis Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.emoji_emotions, color: Colors.orange),
                title: const Text('Quick Mood Analysis'),
                subtitle: const Text('Feeling tired? happy? disturbed?'),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "uses face scanner",
                    style: TextStyle(fontSize: 10, color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Horizontal Date Picker Stub (can be replaced with a custom widget)
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                  final dates = [9, 10, 11, 12, 13, 14, 15];
                  final isSelected = index == 1; // Mark Monday as selected example
                  return Container(
                    width: 56,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(days[index],
                          style: TextStyle(
                            color: isSelected ? Colors.blueAccent : Colors.black54,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 12,
                          )
                        ),
                        const SizedBox(height: 2),
                        Text('${dates[index]}',
                          style: TextStyle(
                            color: isSelected ? Colors.blueAccent : Colors.black54,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            fontSize: 14,
                          )
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Activity Cards Row
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Chip(
                            label: Text("Timed distraction", style: TextStyle(fontSize: 10)),
                            backgroundColor: Colors.blueAccent,
                            labelStyle: TextStyle(color: Colors.white),
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(height: 10),
                          Text('Unwind', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Feeling tired?\nhappy? disturbed?', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Chip(
                            label: Text("Short activities", style: TextStyle(fontSize: 10)),
                            backgroundColor: Colors.orange,
                            labelStyle: TextStyle(color: Colors.white),
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(height: 10),
                          Text('Relax', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Feeling tired?\nhappy? disturbed?', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFDEE6FA), Color(0xFFC4E0F7)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.black54,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
