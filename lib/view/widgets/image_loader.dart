import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String path;
  final BoxFit boxFit;

  const NetworkImageLoader({
    Key? key,
    required this.boxFit,
    required this.path,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(path);
    if (path != "") {
      return Image.network(
        path,
        fit: boxFit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Column(
            children: const [
              Expanded(
                child: Icon(Icons.image),
                flex: 6,
              ),
              Expanded(
                child: Text("Unable to Load image"),
                flex: 3,
              )
            ],
          );
        },
      );
    } else {
      return const Icon(Icons.image);
    }
  }
}
