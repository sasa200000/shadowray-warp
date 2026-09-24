import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/support_link.dart';
import '../../data/services/licence_providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../widgets/rainbow_border_dance.dart';

/// The first screen anyone sees. Nothing else in the app is reachable until a
/// valid subscription code is entered here.
///
/// When the user returns after their code ran out, [expired] tells them why:
/// the same field, but the message explains that the subscription ended and a
/// new code is needed.
class LicenceEntryScreen extends ConsumerStatefulWidget {
  const LicenceEntryScreen({super.key, this.expired = false});

  final bool expired;

  @override
  ConsumerState<LicenceEntryScreen> createState() =>
      _LicenceEntryScreenState();
}

class _LicenceEntryScreenState extends ConsumerState<LicenceEntryScreen> {
  final TextEditingController _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _activate() async {
    final value = _code.text.trim();
    if (value.isEmpty) return;

    setState(() {
      _busy = true;
      _error = null;
    });

    final ok = await ref.read(currentLicenceProvider.notifier).activate(value);
    if (!mounted) return;
    setState(() => _busy = false);
    if (!ok) {
      setState(() => _error = L10n.of(context).licenceInvalid);
    }
  }

  Future<void> _openSupport() async {
    final uri = Uri.parse(kSupportLink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = L10n.of(context);

    return CupertinoPageScaffold(
      backgroundColor: palette.canvas,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    CupertinoIcons.shield_lefthalf_fill,
                    size: 72,
                    color: palette.primary,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l10n.appName.toUpperCase(),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: AppText.wordmark(palette.label),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.expired
                        ? l10n.licenceExpiredTitle
                        : l10n.licenceEntryTitle,
                    textAlign: TextAlign.center,
                    style: AppText.state(palette.labelSecondary),
                  ),
                  const SizedBox(height: 26),
                  RainbowBorderDance(
                    active: !_busy,
                    borderRadius: 16,
                    borderWidth: 2.5,
                    glow: true,
                    padding: const EdgeInsets.all(3),
                    child: CupertinoTextField(
                      controller: _code,
                      placeholder: l10n.licencePlaceholder,
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.characters,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.6,
                      ),
                      onSubmitted: (_) => _activate(),
                    ),
                  ),
                  if (_error != null) ...<Widget>[
                    const SizedBox(height: 10),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: AppText.caption(palette.danger),
                    ),
                  ],
                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    onPressed: _busy ? null : _activate,
                    child: _busy
                        ? const CupertinoActivityIndicator(color: CupertinoColors.white)
                        : Text(l10n.licenceActivate),
                  ),
                  const SizedBox(height: 26),
                  CupertinoButton(
                    onPressed: _openSupport,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(CupertinoIcons.chat_bubble_text, size: 16,
                            color: palette.primary),
                        const SizedBox(width: 8),
                        Text(
                          l10n.supportChannel,
                          style: AppText.caption(palette.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
