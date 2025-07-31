import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_background.dart';

class HomeScreen extends StatelessWidget {
       const HomeScreen({super.key});

       @override
       Widget build(BuildContext context) {
              // Generate dynamic week for calendar row
              final today = DateTime.now();
              final startDate = today.subtract(const Duration(days: 2));
              final weekDates = List.generate(7, (i) => startDate.add(Duration(days: i)));
              final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

              return Scaffold(
                     backgroundColor: Colors.transparent,
                     appBar: AppBar(
                            title: const Text('Welcome Back!'),
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                     ),
                     body: GradientBackground(
                            child: SafeArea(
                                   child: Stack(
                                          children: [
                                                 // Main content
                                                 Padding(
                                                        padding: const EdgeInsets.only(bottom: 100),
                                                        child: ListView(
                                                               padding: const EdgeInsets.all(16),
                                                               children: [
                                                                      // Mood Analysis Card
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
                                                                      
                                                                      // Calendar Row (Today is the 3rd element)
                                                                      Padding(
                                                                             padding: const EdgeInsets.symmetric(vertical: 16),
                                                                             child: SizedBox(
                                                                                    height: 60,
                                                                                    child: ListView.separated(
                                                                                           scrollDirection: Axis.horizontal,
                                                                                           itemCount: 7,
                                                                                           separatorBuilder: (_, __) => const SizedBox(width: 12),
                                                                                           itemBuilder: (context, idx) {
                                                                                                  final date = weekDates[idx];
                                                                                                  final isSelected = idx == 2;
                                                                                                  return Container(
                                                                                                         width: 58,
                                                                                                         decoration: BoxDecoration(
                                                                                                                color: isSelected ? Colors.blue.shade100 : Colors.white,
                                                                                                                borderRadius: BorderRadius.circular(14),
                                                                                                                border: Border.all(
                                                                                                                       color: isSelected ? Colors.blueAccent : Colors.transparent,
                                                                                                                       width: isSelected ? 2 : 1,
                                                                                                                ),
                                                                                                         ),
                                                                                                         alignment: Alignment.center,
                                                                                                         child: Column(
                                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                children: [
                                                                                                                       Text(
                                                                                                                              weekDays[date.weekday % 7],
                                                                                                                              style: TextStyle(
                                                                                                                                     color: isSelected ? Colors.blueAccent : Colors.black54,
                                                                                                                                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                                                                                                                     fontSize: 12,
                                                                                                                              ),
                                                                                                                       ),
                                                                                                                       const SizedBox(height: 2),
                                                                                                                       Text(
                                                                                                                              '${date.day}',
                                                                                                                              style: TextStyle(
                                                                                                                                     color: isSelected ? Colors.blueAccent : Colors.black87,
                                                                                                                                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                                                                                                                     fontSize: 16,
                                                                                                                              ),
                                                                                                                       ),
                                                                                                                ],
                                                                                                         ),
                                                                                                  );
                                                                                           },
                                                                                    ),
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
                                                 // Custom Bottom Button Bar with Home, AI Chat, Profile
                                                 Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Padding(
                                                               padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                                                               child: Container(
                                                                      height: 68,
                                                                      decoration: BoxDecoration(
                                                                             color: Colors.white.withAlpha((0.92*255).round()),
                                                                             borderRadius: BorderRadius.circular(26),
                                                                             boxShadow: [
                                                                                    BoxShadow(
                                                                                           blurRadius: 16,
                                                                                           color: Colors.black12,
                                                                                           offset: Offset(0, 4),
                                                                                    )
                                                                             ],
                                                                      ),
                                                                      child: Row(
                                                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                             children: [
                                                                                    // Home Button
                                                                                    Expanded(
                                                                                           child: GestureDetector(
                                                                                                  onTap: () {
                                                                                                         // Already on Home; Optionally scroll to top or refresh
                                                                                                  },
                                                                                                  child: Row(
                                                                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                                                         children: const [
                                                                                                                Icon(Icons.home_outlined, color: Colors.green),
                                                                                                                SizedBox(width: 8),
                                                                                                                Text(
                                                                                                                       "Home",
                                                                                                                       style: TextStyle(
                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                              color: Colors.green,
                                                                                                                              fontSize: 16,
                                                                                                                       ),
                                                                                                                ),
                                                                                                         ],
                                                                                                  ),
                                                                                           ),
                                                                                    ),
                                                                                    Container(width: 1, height: 38, color: Colors.blueGrey.shade50),
                                                                                    // AI Chat
                                                                                    Expanded(
                                                                                           child: GestureDetector(
                                                                                                  onTap: () {
                                                                                                         Navigator.pushNamed(context, '/ai_chat');
                                                                                                  },
                                                                                                  child: Row(
                                                                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                                                         children: const [
                                                                                                                Icon(Icons.chat_bubble_outline, color: Colors.blue),
                                                                                                                SizedBox(width: 8),
                                                                                                                Text(
                                                                                                                       "AI Chat",
                                                                                                                       style: TextStyle(
                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                              color: Colors.blue,
                                                                                                                              fontSize: 16,
                                                                                                                       ),
                                                                                                                ),
                                                                                                         ],
                                                                                                  ),
                                                                                           ),
                                                                                    ),
                                                                                    Container(width: 1, height: 38, color: Colors.blueGrey.shade50),
                                                                                    // Profile
                                                                                    Expanded(
                                                                                           child: GestureDetector(
                                                                                                  onTap: () {
                                                                                                         Navigator.pushNamed(context, '/profile');
                                                                                                  },
                                                                                                  child: Row(
                                                                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                                                                         children: const [
                                                                                                                Icon(Icons.person_outline, color: Colors.deepPurple),
                                                                                                                SizedBox(width: 8),
                                                                                                                Text(
                                                                                                                       "Profile",
                                                                                                                       style: TextStyle(
                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                              color: Colors.deepPurple,
                                                                                                                              fontSize: 16,
                                                                                                                       ),
                                                                                                                ),
                                                                                                         ],
                                                                                                  ),
                                                                                           ),
                                                                                    ),
                                                                             ],
                                                                      ),
                                                               ),
                                                        ),
                                                 ),
                                          ],
                                   ),
                            ),
                     ),
              );
       }
}
