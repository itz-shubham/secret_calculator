import 'package:flutter/material.dart';
import 'package:secret_calculator/models/gallery_model.dart';
import 'package:secret_calculator/ui/colors.dart';

class ImageViewPage extends StatelessWidget {
  final Gallery image;
  const ImageViewPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [popUpMenu()],
      ),
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          alignPanAxis: true,
          child: Hero(
            tag: image.key.toString(),
            child: Image.memory(image.bytes),
          ),
        ),
      ),
    );
  }

  popUpMenu() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () {
            image.delete();
            Navigator.pop(context);
          },
          child: menuItem(Icons.delete, "Delete", Colors.red),
        ),
      ],
      offset: const Offset(0, 50),
      color: mainColorDark,
      elevation: 2,
      // padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      constraints: const BoxConstraints(minWidth: 128),
    );
  }

  menuItem(IconData iconData, String lable, [Color? color]) {
    return Row(
      children: [
        Icon(iconData, color: color),
        const Spacer(),
        Text(
          lable,
          style: TextStyle(
            color: color ?? Colors.white,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
