import 'package:app/domain/models/social_app.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';

class SocialAppGrid extends StatelessWidget {
  const SocialAppGrid({super.key, required this.socialApps});

  final List<SocialApp> socialApps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Apps',
          style: context.styles.button1,
        ),
        8.heightBox,
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          semanticChildCount: socialApps.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) =>
              SocialAppCard(socialApp: socialApps[index]),
          itemCount: socialApps.length,
        ),
      ],
    );
  }
}

class SocialAppCard extends StatelessWidget {
  const SocialAppCard({super.key, required this.socialApp});

  final SocialApp socialApp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Image.network(socialApp.image),
        ),
      ),
    );
  }
}
