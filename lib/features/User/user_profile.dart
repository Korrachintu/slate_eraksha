import 'package:flutter/material.dart';
import '../../core/widgets/gradient_background.dart';
import '../../models/user.dart';

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
        dateOfBirth: _editableUser.dateOfBirth, // unchanged
        email: _emailController.text,
        accountType: _editableUser.accountType, // unchanged
      );
      _isEditing = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile updated")));
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // let gradient show
        appBar: AppBar(
          title: const Text("User Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
              onPressed: _isEditing ? _saveProfile : _toggleEdit,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              const SizedBox(height: 16),

              // Editable Name
              _isEditing
                  ? TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.tealAccent),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    )
                  : Text(
                      _editableUser.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

              const SizedBox(height: 8),

              // Editable Email
              _isEditing
                  ? TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.tealAccent),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    )
                  : Text(
                      _editableUser.email,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),

              const SizedBox(height: 20),

              // Read-only Account Type
              Card(
                color: Colors.grey[900],
                child: ListTile(
                  leading: const Icon(
                    Icons.account_box,
                    color: Colors.tealAccent,
                  ),
                  title: const Text(
                    "Account Type",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _editableUser.accountType,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              // Read-only Date of Birth
              Card(
                color: Colors.grey[900],
                child: ListTile(
                  leading: const Icon(Icons.cake, color: Colors.tealAccent),
                  title: const Text(
                    "Date of Birth",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${_editableUser.dateOfBirth.toLocal()}".split(' ')[0],
                    style: const TextStyle(color: Colors.grey),
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
