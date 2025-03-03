import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final Color? backgroundColor;

  static const List<Color> avatarColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  const ChatAvatar({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorIndex = name.hashCode % avatarColors.length;
    final avatarColor = backgroundColor ?? avatarColors[colorIndex];

    bool hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return CircleAvatar(
      backgroundColor: avatarColor,
      radius: 25.0,
      child: hasImage
          ? ClipOval(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  return _buildInitials();
                },
              ),
            )
          : _buildInitials(),
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        _getInitials(name),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  String _getInitials(String fullName) {
    List<String> names = fullName.trim().split(" ");
    String initials = names.isNotEmpty ? names[0][0].toUpperCase() : "";
    if (names.length > 1) {
      initials += names[1][0].toUpperCase();
    }
    return initials;
  }
}
