/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/cloudy.png
  AssetGenImage get cloudy => const AssetGenImage('assets/image/cloudy.png');

  /// File path: assets/image/mist_haze.png
  AssetGenImage get mistHaze =>
      const AssetGenImage('assets/image/mist_haze.png');

  /// File path: assets/image/pngwing.com.png
  AssetGenImage get pngwingCom =>
      const AssetGenImage('assets/image/pngwing.com.png');

  /// File path: assets/image/storm.png
  AssetGenImage get storm => const AssetGenImage('assets/image/storm.png');

  /// File path: assets/image/sun.png
  AssetGenImage get sun => const AssetGenImage('assets/image/sun.png');

  /// File path: assets/image/sunny_cloud.png
  AssetGenImage get sunnyCloud =>
      const AssetGenImage('assets/image/sunny_cloud.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [cloudy, mistHaze, pngwingCom, storm, sun, sunnyCloud];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Icon Feels Like.svg
  SvgGenImage get iconFeelsLike =>
      const SvgGenImage('assets/svg/Icon Feels Like.svg');

  /// File path: assets/svg/Icon Wind.svg
  SvgGenImage get iconWind => const SvgGenImage('assets/svg/Icon Wind.svg');

  /// File path: assets/svg/Icon_Humidity.svg
  SvgGenImage get iconHumidity =>
      const SvgGenImage('assets/svg/Icon_Humidity.svg');

  /// File path: assets/svg/forecast_1.svg
  SvgGenImage get forecast1 => const SvgGenImage('assets/svg/forecast_1.svg');

  /// File path: assets/svg/forecast_2.svg
  SvgGenImage get forecast2 => const SvgGenImage('assets/svg/forecast_2.svg');

  /// File path: assets/svg/forecast_3.svg
  SvgGenImage get forecast3 => const SvgGenImage('assets/svg/forecast_3.svg');

  /// File path: assets/svg/forecast_4.svg
  SvgGenImage get forecast4 => const SvgGenImage('assets/svg/forecast_4.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        iconFeelsLike,
        iconWind,
        iconHumidity,
        forecast1,
        forecast2,
        forecast3,
        forecast4
      ];
}

class Assets {
  Assets._();

  static const $AssetsImageGen image = $AssetsImageGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
