import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/licence/licence.dart';
import '../../data/services/licence_providers.dart';
import '../../l10n/generated/app_localizations.dart';

/// The single support channel. No code, no panel, just the admin's contact.
const String kSupportLink = 'https://t.me/SasaX60';

/// Shown when the app opens with no active licence. The user types a code
/// here; support sits under it. Nothing else is reachable from this screen.
class LicenceEntryScreen extends ConsumerStatefulWidget {
  const LicenceEntryScreen({super.key, this.expired = false});

  /// True when the user has a code on file that has simply run out.
  final bool expired;

  @override
  ConsumerState<LicenceEntryScreen> createState() => _LicenceEntryScreenState();
}

class _LicenceEntryScreenState extends ConsumerState<LicenceEntryScreen> {
  final TextEditingController _code = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _submit() async {
    final value = _code.text.trim();
    if (value.isEmpty) {
      setState(() => _error = L10n.of(context).licenceEnterCode);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final ok = await ref.read(currentLicenceProvider.notifier).activate(value);
    if (!mounted) return;
    if (!ok) {
      setState(() {
        _busy = false;
        _error = L10n.of(context).licenceInvalid;
      });
    }
    // On success the app-level gate swaps this screen out for the home screen.
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = CupertinoColors.systemBackground.resolveFrom(context);
    final l10n = L10n.of(context);

    return CupertinoPageScaffold(
      backgroundColor: palette,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    CupertinoIcons.lock_shield_fill,
                    size: 64,
                    color: CupertinoColors.activeBlue.resolveFrom(context),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.licenceTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.expired ? l10n.licenceExpired : l10n.licenceSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.expired
                          ? CupertinoColors.destructiveRed.resolveFrom(context)
                          : CupertinoColors.labelSecondary.resolveFrom(context),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CupertinoTextField(
                    controller: _code,
                    placeholder: l10n.licencePlaceholder,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.characters,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                      fontFeatures: <FontFeature>[
                        FontFeature.tabularFigures()
                      ],
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                  if (_error != null) ...<Widget>[
                    const SizedBox(height: 10),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.destructiveRed.resolveFrom(context),
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  CupertinoButton.filled(
                    onPressed: _busy ? null : _submit,
                    child: _busy
                        ? const CupertinoActivityIndicator()
                        : Text(l10n.licenceActivate),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.chat_bubble_text,
                        size: 16,
                        color: CupertinoColors.labelSecondary.resolveFrom(context),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l10n.supportLabel,
                        style: TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.labelSecondary.resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: GestureDetector(
                      onTap: () => _openSupport(context),
                      child: Text(
                        kSupportLink,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.activeBlue.resolveFrom(context),
                          decoration: TextDecoration.underline,
                        ),
                      ),
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

  void _openSupport(BuildContext context) {
    _launch(kSupportLink);
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Resolves the active licence for the app-level gate.
(Licence?, bool) licenceGateOf(WidgetRef ref) {
  final licence = ref.watch(currentLicenceProvider);
  return (licence, licence != null && !licence.isExpired);
}
