import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timesofindia/models/article_model.dart';
import 'package:timesofindia/view/screen_config_constants.dart';
import 'package:timesofindia/view/widgets/custom_alert_dialogue.dart';
import 'package:timesofindia/view/widgets/image_loader.dart';
import 'package:timesofindia/view/widgets/local_image_loader.dart';
import 'package:timesofindia/view/widgets/secondary_appbar.dart';
import 'package:intl/intl.dart';
import 'package:timesofindia/view_models/news_article_vm.dart';

class ArticleDetailedScreen extends StatefulWidget {
  final double gridHeight, gridWidth;
  final Articles article;
  const ArticleDetailedScreen(
      {Key? key,
      required this.gridHeight,
      required this.gridWidth,
      required this.article})
      : super(key: key);

  @override
  State<ArticleDetailedScreen> createState() => _ArticleDetailedScreenState();
}

class _ArticleDetailedScreenState extends State<ArticleDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    String source = (widget.article.author ?? "") +
        "/" +
        (widget.article.source?.name ?? "") +
        "/ Updated : " +
        (DateFormat("MMM d,yyyy, hh:mm a")
            .format(DateTime.parse(widget.article.publishedAt!)));
    return WillPopScope(
      onWillPop: () {
        if (Provider.of<NewsArticleVM>(context, listen: false)
                .pickedImageFile !=
            null) {
          Provider.of<NewsArticleVM>(context, listen: false).removeImage();
        }
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: widget.gridHeight * 100,
            width: widget.gridWidth * 100,
            child: Column(
              children: [
                SecondaryAppBar(
                    action: Container(),
                    gridHeight: widget.gridHeight,
                    gridWidth: widget.gridWidth),
                Expanded(
                    child: Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: widget.gridHeight,
                                    horizontal: widget.gridWidth * 2),
                                width: widget.gridWidth * 100,
                                child: Text(
                                  widget.article.title ?? "No Title",
                                  style: ScreenConfig.blackH2Bold,
                                ),
                              ),
                              SizedBox(
                                width: widget.gridWidth * 100,
                                height: widget.gridHeight * 5,
                                child: Text(
                                  source,
                                  style: ScreenConfig.greyH6,
                                ),
                              ),
                              Consumer<NewsArticleVM>(
                                  builder: (context, newsArticleVM, _) {
                                if (newsArticleVM.pickedImageFile == null) {
                                  return Container(
                                    color: Colors.grey.withOpacity(.3),
                                    child: Center(
                                      child: NetworkImageLoader(
                                          boxFit: BoxFit.fitHeight,
                                          path:
                                              widget.article.urlToImage ?? ""),
                                    ),
                                    height: widget.gridHeight * 30,
                                    width: widget.gridWidth * 100,
                                  );
                                } else {
                                  return Container(
                                    color: Colors.grey.withOpacity(.3),
                                    child: Center(
                                        child: LocalImageLoader(
                                            gridHeight: widget.gridHeight,
                                            gridWidth: widget.gridWidth,
                                            file: newsArticleVM
                                                .pickedImageFile!)),
                                    height: widget.gridHeight * 30,
                                    width: widget.gridWidth * 100,
                                  );
                                }
                              }),
                              Consumer<NewsArticleVM>(
                                  builder: (context, newsArticleVm, _) {
                                if (newsArticleVm.pickedImageFile?.path ==
                                    null) {
                                  return TextButton.icon(
                                      style: TextButton.styleFrom(
                                          backgroundColor: ScreenConfig.appBar),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomAlertDialogueBox(
                                                    b1: "Gallery",
                                                    b2: "Camera",
                                                    content:
                                                        "Choose an image from",
                                                    navigation1: () {
                                                      _pickImage(
                                                              context,
                                                              ImageSource
                                                                  .gallery)
                                                          .then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    navigation2: () {
                                                      _pickImage(
                                                              context,
                                                              ImageSource
                                                                  .camera)
                                                          .then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    title: "Replace the image?",
                                                    icon: Container(),
                                                    gridWidth: widget.gridWidth,
                                                    gridHeight:
                                                        widget.gridHeight));
                                      },
                                      icon: Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                        size: widget.gridHeight * 3,
                                      ),
                                      label: Text(
                                        "Add your own picture",
                                        style: ScreenConfig.whiteH5,
                                      ));
                                } else {
                                  return TextButton.icon(
                                      style: TextButton.styleFrom(
                                          backgroundColor: ScreenConfig.appBar),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                CustomAlertDialogueBox(
                                                    b1: "no",
                                                    b2: "yes",
                                                    content:
                                                        "do you want to crop the image",
                                                    navigation1: () {
                                                      Navigator.pop(context);
                                                    },
                                                    navigation2: () {
                                                      _cropImage(
                                                              newsArticleVm
                                                                  .pickedImageFile!
                                                                  .path,
                                                              context)
                                                          .then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    },
                                                    title: "Crop the image?",
                                                    icon: Container(),
                                                    gridWidth: widget.gridWidth,
                                                    gridHeight:
                                                        widget.gridHeight));
                                      },
                                      icon: Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                        size: widget.gridHeight * 3,
                                      ),
                                      label: Text(
                                        "Crop your picture",
                                        style: ScreenConfig.whiteH5,
                                      ));
                                }
                              }),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: widget.gridWidth,
                                    vertical: widget.gridHeight * 2),
                                child: Text(
                                  widget.article.content ?? "No Content",
                                  style: ScreenConfig.blackH6,
                                ),
                              ),
                            ],
                          ),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _cropImage(String path, BuildContext context) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        compressFormat: ImageCompressFormat.jpg,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      Provider.of<NewsArticleVM>(context, listen: false).setImage(croppedFile);
    }
  }

  Future _pickImage(BuildContext context, ImageSource imageSource) async {
    XFile? ximageFile =
        await ImagePicker().pickImage(source: imageSource, imageQuality: 10);
    if (ximageFile != null) {
      File image = File(ximageFile.path);
      Provider.of<NewsArticleVM>(context, listen: false).setImage(image);
    }
  }
}
