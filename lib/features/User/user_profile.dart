import 'package:flutter/material.dart';
import '../../core/widgets/gradient_background.dart';
import '../../models/user.dart';
import 'package:e_raksha/core/widgets/custom_botton_bar.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  const UserProfilePage({super.key, required this.user});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late User _editableUser;
  bool _isEditing = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editableUser = widget.user;
    _nameController.text = _editableUser.name;
    _emailController.text = _editableUser.email;
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    setState(() {
      _editableUser = User(
        name: _nameController.text,
        dateOfBirth: _editableUser.dateOfBirth,
        email: _emailController.text,
        accountType: _editableUser.accountType,
      );
      _isEditing = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile updated")));
  }

  @override
  Widget build(BuildContext context) {
    String firstLetter = _editableUser.name.isNotEmpty
        ? _editableUser.name[0].toUpperCase()
        : "?";

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("User Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
              onPressed: _isEditing ? _saveProfile : _toggleEdit,
              color: Colors.white,
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      firstLetter,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Name
                  _isEditing
                      ? editableCard("Name", _nameController)
                      : cardBlock("Name", _editableUser.name),
                  const SizedBox(height: 12),

                  // Date of Birth (read-only)
                  cardBlock(
                    "Date of Birth",
                    "${_editableUser.dateOfBirth.toLocal()}".split(' ')[0],
                  ),
                  const SizedBox(height: 12),

                  // Email
                  _isEditing
                      ? editableCard("Email", _emailController)
                      : cardBlock("Email", _editableUser.email),
                  const SizedBox(height: 12),

                  // Account Type (read-only)
                  cardBlock("Account Type", _editableUser.accountType),

                  const SizedBox(height: 100), // Extra space for bottom bar
                ],
              ),
            ),

            // ✅ Custom Bottom Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                child: CustomBottomBar(
                  backgroundColor: Colors.black.withAlpha((0.92 * 255).round()),
                  borderRadius: 28,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/home'),
                        tooltip: "Home",
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/ai_chat'),
                        tooltip: "AI Chat",
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/user_profile'),
                        tooltip: "Profile",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardBlock(String label, String value) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF264366),
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF555E6E),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editableCard(String label, TextEditingController controller) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white.withOpacity(0.92),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF555E6E),
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Color(0xFF264366),
              fontWeight: FontWeight.bold,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
