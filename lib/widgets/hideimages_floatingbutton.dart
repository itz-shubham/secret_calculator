import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_manager/photo_manager.dart';

import '../models/gallery_model.dart';

class HideImagesButton extends StatefulWidget {
  final List<AssetEntity> selectedAssets;
  final Function onHideComplete;
  const HideImagesButton({
    Key? key,
    required this.selectedAssets,
    required this.onHideComplete,
  }) : super(key: key);

  @override
  State<HideImagesButton> createState() => _HideImagesButtonState();
}

class _HideImagesButtonState extends State<HideImagesButton> {
  bool hiding = false;
  @override
  Widget build(BuildContext context) {
    if (hiding) {
      return FloatingActionButton(
        onPressed: () => hide(),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: () => hide(),
        label: Text("Hide Images (${widget.selectedAssets.length})"),
      );
    }
  }

  Future<void> hide() async {
    setState(() => hiding = true);
    final box = Hive.box<Gallery>('gallery');
    List<String> alreadyHiddenImagesPath = [];
    box.values.toList().forEach((image) {
      return alreadyHiddenImagesPath.add(image.localPath);
    });
    int saveImageCount = 0;
    for (var asset in widget.selectedAssets) {
      var imageFile = await asset.loadFile();
      if (imageFile != null) {
        if (!alreadyHiddenImagesPath.contains(imageFile.path)) {
          var thumbnailBytes = await asset.thumbnailDataWithSize(
            const ThumbnailSize.square(256),
          );
          if (thumbnailBytes != null) {
            box.add(Gallery(
              type: 'image',
              thumbnailBytes: thumbnailBytes,
              bytes: imageFile.readAsBytesSync(),
              dateTime: DateTime.now(),
              localPath: imageFile.path,
            ));
            saveImageCount++;
          }
        }
      }
    }
    if (saveImageCount != 0) {
      Fluttertoast.showToast(
        msg: "Hidden successfully",
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(msg: "Skipped hiding");
    }
    setState(() => hiding = false);
    widget.onHideComplete();
  }
}
