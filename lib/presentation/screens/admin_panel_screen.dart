import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show SelectableText;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/licence/licence.dart';
import '../../data/licence/licence_minter.dart';
import '../../data/licence/licence_store.dart';
import '../../data/services/licence_providers.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/rainbow_border_dance.dart';

/// The admin panel, hidden behind a lock code.
///
/// From here the admin (you) generates codes for every plan and device tier,
/// changes the lock code that protects this panel, and sees the codes this
/// device has already issued. The panel is unreachable until the lock code is
/// typed correctly, and admin privileges never expire: it is your app.
class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  bool _unlocked = false;
  final TextEditingController _lockInput = TextEditingController();
  final TextEditingController _newLock = TextEditingController();
  String? _planId = '1M';
  int _devices = 1;
  String? _lastMinted;
  String? _lockError;

  @override
  void dispose() {
    _lockInput.dispose();
    _newLock.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    final store = await ref.read(licenceStoreProvider.future);
    if (!mounted) return;
    if (_lockInput.text.trim() == store.adminLock) {
      setState(() {
        _unlocked = true;
        _lockError = null;
      });
    } else {
      setState(() => _lockError = L10n.of(context).adminLockWrong);
    }
  }

  Future<void> _changeLock() async {
    final next = _newLock.text.trim();
    if (next.length < 6) {
      setState(() => _lockError = L10n.of(context).adminLockTooShort);
      return;
    }
    final store = await ref.read(licenceStoreProvider.future);
    await store.setAdminLock(next);
    if (!mounted) return;
    setState(() {
      _lockError = null;
      _newLock.clear();
    });
    // ignore: use_build_context_synchronously
    _toast(L10n.of(context).adminLockChanged);
  }

  Future<void> _mint() async {
    final planId = _planId;
    if (planId == null) return;
    final code = LicenceMinter.mint(planId: planId, devices: _devices);
    final store = await ref.read(licenceStoreProvider.future);
    await store.rememberMintedCode(code);
    if (!mounted) return;
    setState(() => _lastMinted = code);
  }

  void _toast(String message) {
    // A plain Cupertino alert keeps the widget tree free of new dependencies.
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(),
            child: Text(L10n.of(context).confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    if (!_unlocked) {
      return _lockScreen(l10n);
    }
    return _panel(l10n);
  }

  Widget _lockScreen(L10n l10n) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.adminTitle)),
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
                    CupertinoIcons.lock_fill,
                    size: 56,
                    color: CupertinoColors.activeBlue.resolveFrom(context),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.adminLockPrompt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  RainbowBorderDance(
                    active: true,
                    borderRadius: 14,
                    borderWidth: 2.5,
                    glow: true,
                    padding: const EdgeInsets.all(3),
                    child: CupertinoTextField(
                      controller: _lockInput,
                      placeholder: l10n.adminLockPlaceholder,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    textAlign: TextAlign.center,
                      onSubmitted: (_) => _unlock(),
                    ),
                  ),
                  if (_lockError != null) ...<Widget>[
                    const SizedBox(height: 10),
                    Text(
                      _lockError!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CupertinoColors.destructiveRed.resolveFrom(context),
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  CupertinoButton.filled(
                    onPressed: _unlock,
                    child: Text(l10n.adminUnlock),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _panel(L10n l10n) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(l10n.adminTitle)),
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(l10n.adminGenerate,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  _planPicker(l10n),
                  const SizedBox(height: 12),
                  _devicePicker(l10n),
                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    onPressed: _mint,
                    child: Text(l10n.adminGenerateButton),
                  ),
                  if (_lastMinted != null) ...<Widget>[
                    const SizedBox(height: 16),
                    RainbowBorderDance(
                      active: true,
                      borderRadius: 14,
                      borderWidth: 3,
                      glow: true,
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6
                              .resolveFrom(context),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              l10n.adminCodeReady,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                          SelectableText(
                            _lastMinted!,
                            style: const TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.6,
                              fontFeatures: <FontFeature>[
                                FontFeature.tabularFigures()
                              ],
                            ),
                          ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                  _history(l10n),
                  const SizedBox(height: 28),
                  _lockChanger(l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _planPicker(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(l10n.adminPlan, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: LicencePlans.known.values.map((LicencePlan plan) {
            final selected = _planId == plan.id;
            return RainbowBorderDance(
              active: selected,
              borderRadius: 20,
              borderWidth: selected ? 3 : 1.5,
              glow: selected,
              padding: const EdgeInsets.all(2),
              child: GestureDetector(
                onTap: () => setState(() => _planId = plan.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? CupertinoColors.activeBlue.resolveFrom(context)
                        : CupertinoColors.systemGrey6.resolveFrom(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    plan.label,
                    style: TextStyle(
                      color: selected
                          ? CupertinoColors.white
                          : CupertinoColors.label.resolveFrom(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _devicePicker(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(l10n.adminDevices, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: LicencePlans.deviceTiers.map((int tier) {
            final selected = _devices == tier;
            return RainbowBorderDance(
              active: selected,
              borderRadius: 20,
              borderWidth: selected ? 3 : 1.5,
              glow: selected,
              padding: const EdgeInsets.all(2),
              child: GestureDetector(
                onTap: () => setState(() => _devices = tier),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? CupertinoColors.activeBlue.resolveFrom(context)
                        : CupertinoColors.systemGrey6.resolveFrom(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$tier ${l10n.adminDeviceUnit}',
                    style: TextStyle(
                      color: selected
                          ? CupertinoColors.white
                          : CupertinoColors.label.resolveFrom(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _history(L10n l10n) {
    final store = ref.watch(licenceStoreProvider);
    final codes = store.maybeWhen(
      data: (store) => store.mintedCodes,
      orElse: () => <String>[],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(l10n.adminHistory,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        if (codes.isEmpty)
          Text(l10n.adminHistoryEmpty,
              style: TextStyle(
                  color: context.palette.labelSecondary))
        else
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.resolveFrom(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: codes
                  .take(12)
                  .map((String code) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SelectableText(
                          code,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _lockChanger(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(l10n.adminChangeLock,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        RainbowBorderDance(
          active: true,
          borderRadius: 14,
          borderWidth: 2.5,
          glow: false,
          padding: const EdgeInsets.all(3),
          child: CupertinoTextField(
            controller: _newLock,
            placeholder: l10n.adminNewLockPlaceholder,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          ),
        ),
        const SizedBox(height: 10),
        CupertinoButton(
          onPressed: _changeLock,
          child: Text(l10n.adminChangeLockButton),
        ),
      ],
    );
  }
}
