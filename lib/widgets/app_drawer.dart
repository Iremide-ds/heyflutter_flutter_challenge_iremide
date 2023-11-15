import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/config/dimensions.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/util/context_extensions.dart';

final Uri _portfolio = Uri.parse(
    'https://married-part-e96.notion.site/Iremide-s-Portfolio-7421bd34eed94df89d550c99a22dcb7f?pvs=4');
final Uri _linkedin =
    Uri.parse('https://www.linkedin.com/in/iremide-adeboye-02b2b5206/');
final Uri _github = Uri.parse('https://www.github.com/Iremide-ds');
final Uri _unsplash = Uri.parse('https://unsplash.com/');
final Uri _weather = Uri.parse('https://openweathermap.org/');

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({super.key});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  TextStyle _textStyle = TextStyle(fontSize: 20.sp);

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      // ignore: use_build_context_synchronously
      context.showSnackBar('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          height: DesignDimensions.deviceHeight.h,
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Container(
                height: 95.h,
                width: 95.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: Assets.image.pngwingCom.provider(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text('Iremide Adeboye', style: _textStyle),
              const Text('Software engineer'),
              const Spacer(),
              ListTile(
                onTap: () async => await _launchUrl(_portfolio),
                title: Text('My portfolio', style: _textStyle),
                subtitle: const Text('View my projects'),
              ),
              ListTile(
                onTap: () async => await _launchUrl(_linkedin),
                title: Text('Linkedin', style: _textStyle),
                subtitle: const Text('View my profile'),
              ),
              ListTile(
                onTap: () async => await _launchUrl(_github),
                title: Text('Github', style: _textStyle),
                subtitle: const Text('View my projects'),
              ),
              ListTile(
                onTap: () async => await _launchUrl(_unsplash),
                title: Text('Weather API', style: _textStyle),
                subtitle: const Text('Free weather api'),
              ),
              ListTile(
                onTap: () async => await _launchUrl(_unsplash),
                title: Text('Image API', style: _textStyle),
                subtitle: const Text('Free image api'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
