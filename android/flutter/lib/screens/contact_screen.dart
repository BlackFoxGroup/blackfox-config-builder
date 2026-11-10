import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/theme/fox_colors.dart';
import '../l10n/app_localizations.dart';
import '../services/contact_feed_service.dart';
import '../widgets/op_tile.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Future<PackageInfo>? _packageInfo;

  @override
  void initState() {
    super.initState();
    _packageInfo = PackageInfo.fromPlatform();
    ContactFeedService.instance.refresh();
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _telegramUrl(String handle) {
    return 'https://t.me/${handle.replaceAll('@', '')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final contacts = ContactFeedService.instance;

    return ListenableBuilder(
      listenable: contacts,
      builder: (context, _) {
        final feed = contacts.feed;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            OpTile(
              label: contacts.pick(feed?.websiteDisplay, l10n.contactWebsiteDisplay),
              style: OpTileStyle.secondary,
              trailing: const Icon(Icons.open_in_new, color: FoxColors.muted),
              onTap: () => _open(
                contacts.pick(feed?.websiteLink, l10n.contactWebsiteLink),
              ),
            ),
            OpTile(
              label: contacts.pick(feed?.emailDisplay, l10n.contactEmailDisplay),
              style: OpTileStyle.secondary,
              trailing: const Icon(Icons.email_outlined, color: FoxColors.muted),
              onTap: () => _open(
                contacts.pick(feed?.emailLink, l10n.contactEmailLink),
              ),
            ),
            OpTile(
              label: contacts.pick(feed?.githubDisplay, l10n.contactGithubDisplay),
              style: OpTileStyle.secondary,
              trailing: Image.asset(
                'assets/images/github-mark.png',
                width: 20,
                height: 20,
                color: FoxColors.muted,
              ),
              onTap: () => _open(
                contacts.pick(feed?.githubLink, l10n.contactGithubLink),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                l10n.contactTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 32),
            OpTile(
              label: l10n.contactChannel,
              subtitle: contacts.pick(feed?.channelLink, l10n.contactChannelLink),
              style: OpTileStyle.secondary,
              trailing: const Icon(Icons.send, color: FoxColors.muted),
              onTap: () => _open(
                _telegramUrl(
                  contacts.pick(feed?.channelLink, l10n.contactChannelLink),
                ),
              ),
            ),
            OpTile(
              label: l10n.contactSupport,
              subtitle: contacts.pick(feed?.supportLink, l10n.contactSupportLink),
              style: OpTileStyle.secondary,
              trailing: const Icon(Icons.support_agent, color: FoxColors.muted),
              onTap: () => _open(
                _telegramUrl(
                  contacts.pick(feed?.supportLink, l10n.contactSupportLink),
                ),
              ),
            ),
            OpTile(
              label: l10n.contactBot,
              subtitle: contacts.pick(feed?.botLink, l10n.contactBotLink),
              style: OpTileStyle.secondary,
              trailing: const Icon(Icons.smart_toy_outlined, color: FoxColors.muted),
              onTap: () => _open(
                _telegramUrl(contacts.pick(feed?.botLink, l10n.contactBotLink)),
              ),
            ),
            OpTile(
              label: l10n.contactGroup,
              subtitle: contacts.pick(feed?.groupLink, l10n.contactGroupLink),
              style: OpTileStyle.secondary,
              trailing: const Icon(Icons.groups_outlined, color: FoxColors.muted),
              onTap: () => _open(
                _telegramUrl(
                  contacts.pick(feed?.groupLink, l10n.contactGroupLink),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.contactTelegramNote,
              style: const TextStyle(color: FoxColors.muted, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FutureBuilder<PackageInfo>(
              future: _packageInfo,
              builder: (context, snapshot) {
                final version = snapshot.data?.version ?? '…';
                return Center(
                  child: Text(
                    '${l10n.contactVersion} $version',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                l10n.contactThanks,
                style: const TextStyle(
                  color: FoxColors.muted,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
