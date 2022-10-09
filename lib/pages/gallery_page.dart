import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secret_calculator/models/gallery_model.dart';
import 'package:secret_calculator/pages/image_picker_page.dart';
import 'package:secret_calculator/pages/imageview_page.dart';
import 'package:secret_calculator/pages/setting_page.dart';
import 'package:secret_calculator/ui/colors.dart';

import '../functions/storage_permission_check.dart';
import '../widgets/perminssion_denied_snackbar.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool selectionEnabled = false;
  List<int> selectedImageKeys = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gallery"),
          actions: [actionButton()],
        ),
        // await Hive.openBox<Gallery>('gallery');
        body: FutureBuilder<Box<Gallery>>(
          future: Hive.openBox('gallery'),
          builder: (context, galleryBoxSnapshot) {
            if (galleryBoxSnapshot.hasError) {
              return Center(
                child: Text(galleryBoxSnapshot.error.toString()),
              );
            }
            if (galleryBoxSnapshot.hasData && galleryBoxSnapshot.data != null) {
              return ValueListenableBuilder<Box<Gallery>>(
                valueListenable: galleryBoxSnapshot.data!.listenable(),
                builder: (context, galleryBox, child) {
                  final images = galleryBox.values.toList();
                  if (images.isEmpty) {
                    return const Center(child: Text("Add Images Here!"));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return imageGrid(context, images[index],
                          selectedImageKeys.contains(images[index].key));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 120,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            storagePermissionCheck(
              onPermissionGranted: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImagePickerPage(),
                  ),
                );
              },
              onPermissionDenied: () => permissionDeniedSnackBar(context),
            );
          },
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }

  Widget actionButton() {
    if (selectedImageKeys.isEmpty) {
      return IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ),
        ),
        icon: const Icon(Icons.settings),
      );
    } else {
      return IconButton(
        onPressed: () {
          final box = Hive.box<Gallery>('gallery');
          for (var key in selectedImageKeys) {
            box.delete(key);
          }
          selectionEnabled = false;
          selectedImageKeys.clear();
          setState(() {});
        },
        icon: const Icon(Icons.delete),
      );
    }
  }

  GestureDetector imageGrid(context, Gallery image, bool selected) {
    return GestureDetector(
      onTap: () {
        if (selectionEnabled) {
          selected
              ? selectedImageKeys.remove(image.key)
              : selectedImageKeys.add(image.key);
          if (selected && selectedImageKeys.isEmpty) selectionEnabled = false;
          setState(() {});
          return;
        }
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (context) => ImageViewPage(image: image),
        );
      },
      onLongPress: () {
        HapticFeedback.lightImpact();
        selectionEnabled = true;
        selectedImageKeys.add(image.key);
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: selected ? Border.all(width: 2, color: secondaryColor) : null,
          image: DecorationImage(
            image: MemoryImage(image.thumbnailBytes),
            fit: BoxFit.cover,
          ),
        ),
        child: selected
            ? const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.check_circle, color: secondaryColor),
              )
            : null,
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (selectionEnabled) {
      selectionEnabled = false;
      selectedImageKeys.clear();
      setState(() {});
      return false;
    } else {
      return true;
    }
  }
}
