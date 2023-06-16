import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yummy/generated/assets.dart';

class CustomCachedImage extends StatelessWidget {
  final String imgUrl;
  const CustomCachedImage({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) =>  Lottie.asset(Assets.animationImageLoading,
          fit: BoxFit.cover)  ,
      errorWidget: (context, url, error) =>
      const Image(image: AssetImage(Assets.imageLoadImage), fit: BoxFit.cover,)  ,

    );
  }
}
