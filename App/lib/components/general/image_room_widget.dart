import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.path,
      this.isNetwork = false,
      this.width,
      this.height});
  final String path;
  final double? width;
  final double? height;
  final bool isNetwork;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: !isNetwork
          ? Image.asset(
              path,
              width: width ?? context.getWidth - 80,
              height: height ?? 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => SizedBox(
                height: height ?? 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width ?? context.getWidth - 80,
                      height: height ?? 200,
                      padding: EdgeInsets.only(bottom: 40),
                      color: Colors.white,
                      child: Icon(
                        Icons.error,
                        color: Colors.blueGrey.shade700,
                        size: 80,
                      ),
                    ),
                    const Text(
                      'Image not found',
                    )
                  ],
                ),
              ),
            )
          : Image.network(
              path,
              width: width ?? context.getWidth - 80,
              height: height ?? 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => SizedBox(
                height: height ?? 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width ?? context.getWidth - 80,
                      height: height ?? 200,
                      padding: EdgeInsets.only(bottom: 40),
                      color: Colors.white,
                      child: Icon(
                        Icons.error,
                        color: Colors.blueGrey.shade700,
                        size: 80,
                      ),
                    ),
                    Text(
                      'Image not found',
                    )
                  ],
                ),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress?.expectedTotalBytes == null) {
                  return child;
                }
                return const CircularProgressIndicator(
                  color: Colors.black,
                );
              },
            ),
    );
  }
}
