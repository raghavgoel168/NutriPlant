import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FullScreenImageScreen.dart';

class PlantFolderScreen extends StatefulWidget {
  final String folderName;

  PlantFolderScreen({required this.folderName});

  @override
  _PlantFolderScreenState createState() => _PlantFolderScreenState();
}

class _PlantFolderScreenState extends State<PlantFolderScreen> {
  List<String> plantImages = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      plantImages = (prefs.getStringList(widget.folderName) ?? []);
    });
  }

  Future<void> _saveImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(widget.folderName, plantImages);
  }

  Future<void> _addImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        plantImages.add(image.path);
      });
      await _saveImages();
    }
  }

  void _showAddImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _addImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _addImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteImage(int index) async {
    setState(() {
      plantImages.removeAt(index);
    });
    await _saveImages();
  }

  void _viewImageFullScreen(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageScreen(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
      ),
      body: plantImages.isEmpty
          ? Center(child: Text('No plants added. Tap "+" to add a photo.'))
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: plantImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _viewImageFullScreen(plantImages[index]),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    File(plantImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteImage(index),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddImageOptions,
        child: Icon(Icons.add),
      ),
    );
  }
}
