import 'package:flutter/material.dart';

class CommonNetworkImage extends StatelessWidget {
  final String? imageUrl; // The URL of the network image
  final String placeholder; // Path to the placeholder asset
  final String errorPlaceholder; // Path to the error fallback asset
  final BoxFit fit; // BoxFit for the image
  final Duration fadeInDuration; // Duration for fade-in animation

  const CommonNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholder = 'assets/images/placeholder.png',
    this.errorPlaceholder = 'assets/images/error_placeholder.png',
    this.fit = BoxFit.cover,
    this.fadeInDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: const NetworkImage(
          "https://media.istockphoto.com/id/1222357475/vector/image-preview-icon-picture-placeholder-for-website-or-ui-ux-design-vector-illustration.jpg?s=612x612&w=0&k=20&c=KuCo-dRBYV7nz2gbk4J9w1WtTAgpTdznHu55W9FjimE="),
      // Placeholder image
      image: NetworkImage(imageUrl ?? ""),
      // Network image
      fit: fit,
      fadeInDuration: fadeInDuration,
      // Smooth fade-in effect
      placeholderFit: fit,
      imageErrorBuilder: (context, error, stackTrace) {
        // Handle error with fallback image
        return const SizedBox();
      },
    );
  }
}
