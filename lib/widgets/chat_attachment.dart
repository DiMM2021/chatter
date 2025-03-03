import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatAttachment extends StatefulWidget {
  final Function(String imagePath) onImageSelected;

  const ChatAttachment({super.key, required this.onImageSelected});

  @override
  _ChatAttachmentState createState() => _ChatAttachmentState();
}

class _ChatAttachmentState extends State<ChatAttachment> {
  bool isImagePickerActive = false;

  Future<void> _pickImage() async {
    if (isImagePickerActive) return;

    setState(() {
      isImagePickerActive = true;
    });

    try {
      var status = await Permission.photos.request();
      if (status.isGranted) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          widget.onImageSelected(pickedFile.path);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Нет разрешения на доступ к фото')),
        );
      }
    } catch (e) {
      print("Ошибка при выборе изображения: $e");
    } finally {
      setState(() {
        isImagePickerActive = false;
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.black),
                title: Text('Выбрать из галереи'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(15.0),
        color: stroke,
        child: GestureDetector(
          onTap: _showImageSourceDialog,
          child: SvgPicture.asset(
            'assets/icons/custom_attach.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
