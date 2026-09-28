import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Renders expense images whether they are network URLs, Base64 strings, or local File paths.
class ExpenseImageView extends StatelessWidget {
  final String imageSource;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ExpenseImageView({
    super.key,
    required this.imageSource,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageSource.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    // Network image
    if (imageSource.startsWith('http://') || imageSource.startsWith('https://')) {
      return Image.network(
        imageSource,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (ctx, err, stack) => _buildErrorWidget(),
      );
    }

    // Base64 image
    if (imageSource.startsWith('data:image') || _isBase64(imageSource)) {
      try {
        final cleanBase64 = imageSource.contains(',') ? imageSource.split(',').last : imageSource;
        final bytes = base64Decode(cleanBase64.trim());
        return Image.memory(
          bytes,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (ctx, err, stack) => _buildErrorWidget(),
        );
      } catch (_) {
        return _buildErrorWidget();
      }
    }

    // Local file path (mobile / desktop)
    if (!kIsWeb) {
      final file = File(imageSource);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (ctx, err, stack) => _buildErrorWidget(),
        );
      }
    }

    return _buildErrorWidget();
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade300,
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.grey, size: 24),
      ),
    );
  }

  bool _isBase64(String str) {
    if (str.length < 20) return false;
    final clean = str.contains(',') ? str.split(',').last : str;
    try {
      base64Decode(clean.trim());
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// Helper dialog to view receipt image in full-screen with zoom support.
void showImagePreviewDialog(BuildContext context, String imageSource) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.black87,
      insetPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ExpenseImageView(
                    imageSource: imageSource,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
