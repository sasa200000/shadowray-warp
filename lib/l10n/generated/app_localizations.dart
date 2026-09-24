// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

/// Callers can lookup localized strings with an instance of L10n returned by
/// [L10n.of]. This class also defines the messages for each locale.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    final String lang = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();
    switch (lang) {
      case 'en':
        return SynchronousFuture<L10n>(AppLocalizationsEn(locale.toString()));
      case 'fa':
        return SynchronousFuture<L10n>(AppLocalizationsFa(locale.toString()));
      default:
        return SynchronousFuture<L10n>(AppLocalizationsEn(locale.toString()));
    }
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// about
  String get about;

  /// aboutApp
  String get aboutApp;

  /// aboutAppSummary
  String get aboutAppSummary;

  /// aboutBody
  String get aboutBody;

  /// aboutCore
  String get aboutCore;

  /// aboutCoreRepo
  String get aboutCoreRepo;

  /// aboutCredits
  String get aboutCredits;

  /// aboutFooter
  String get aboutFooter;

  /// aboutHev
  String get aboutHev;

  /// aboutHevDesc
  String get aboutHevDesc;

  /// aboutInMemory
  String get aboutInMemory;

  /// aboutLicense
  String get aboutLicense;

  /// aboutSource
  String get aboutSource;

  /// aboutVersion
  String get aboutVersion;

  /// adminChangeLock
  String get adminChangeLock;

  /// adminChangeLockButton
  String get adminChangeLockButton;

  /// adminCodeReady
  String get adminCodeReady;

  /// adminDeviceUnit
  String get adminDeviceUnit;

  /// adminDevices
  String get adminDevices;

  /// adminGenerate
  String get adminGenerate;

  /// adminGenerateButton
  String get adminGenerateButton;

  /// adminHistory
  String get adminHistory;

  /// adminHistoryEmpty
  String get adminHistoryEmpty;

  /// adminLockChanged
  String get adminLockChanged;

  /// adminLockPlaceholder
  String get adminLockPlaceholder;

  /// adminLockPrompt
  String get adminLockPrompt;

  /// adminLockTooShort
  String get adminLockTooShort;

  /// adminLockWrong
  String get adminLockWrong;

  /// adminNewLockPlaceholder
  String get adminNewLockPlaceholder;

  /// adminPlan
  String get adminPlan;

  /// adminTitle
  String get adminTitle;

  /// adminUnlock
  String get adminUnlock;

  /// advancedDesc
  String get advancedDesc;

  /// allowLan
  String get allowLan;

  /// allowLanDesc
  String get allowLanDesc;

  /// appDisplayName
  String get appDisplayName;

  /// appName
  String get appName;

  /// appTagline
  String get appTagline;

  /// apply
  String get apply;

  /// cancel
  String get cancel;

  /// chipFullTunnel
  String get chipFullTunnel;

  /// chipNotProtected
  String get chipNotProtected;

  /// chipProxyOnly
  String get chipProxyOnly;

  /// chipSocksOnly
  String get chipSocksOnly;

  /// chipSystemProxy
  String get chipSystemProxy;

  /// clearLogs
  String get clearLogs;

  /// confirm
  String get confirm;

  /// connectAction
  String get connectAction;

  /// connectionFailedRetry
  String get connectionFailedRetry;

  /// copiedToClipboard
  String get copiedToClipboard;

  /// copyLogs
  String get copyLogs;

  /// dataCheck
  String get dataCheck;

  /// dataCheckDesc
  String get dataCheckDesc;

  /// detectingLocation
  String get detectingLocation;

  /// disconnectAction
  String get disconnectAction;

  /// dnsOverride
  String get dnsOverride;

  /// dnsOverrideDesc
  String get dnsOverrideDesc;

  /// dnsServers
  String get dnsServers;

  /// dnsServersDesc
  String get dnsServersDesc;

  /// downloaded
  String get downloaded;

  /// duration
  String get duration;

  /// ech
  String get ech;

  /// echDesc
  String get echDesc;

  /// endpoint
  String get endpoint;

  /// endpointAuto
  String get endpointAuto;

  /// endpointDesc
  String get endpointDesc;

  /// endpointManualHint
  String get endpointManualHint;

  /// exitConfirm
  String get exitConfirm;

  /// exitLocation
  String get exitLocation;

  /// exitNode
  String get exitNode;

  /// fragment
  String get fragment;

  /// fragmentDelay
  String get fragmentDelay;

  /// fragmentDesc
  String get fragmentDesc;

  /// fragmentNeedsHttp2
  String get fragmentNeedsHttp2;

  /// fragmentSize
  String get fragmentSize;

  /// fullTunnelDesc
  String get fullTunnelDesc;

  /// gatewayAutoHint
  String get gatewayAutoHint;

  /// gatewayLabel
  String get gatewayLabel;

  /// geoUnavailable
  String get geoUnavailable;

  /// h2Endpoint
  String get h2Endpoint;

  /// h2EndpointDesc
  String get h2EndpointDesc;

  /// introBody
  String get introBody;

  /// introContinue
  String get introContinue;

  /// introCredit
  String get introCredit;

  /// introFeatureAccountBody
  String get introFeatureAccountBody;

  /// introFeatureAccountTitle
  String get introFeatureAccountTitle;

  /// introFeatureControlBody
  String get introFeatureControlBody;

  /// introFeatureControlTitle
  String get introFeatureControlTitle;

  /// introFeatureTunnelBody
  String get introFeatureTunnelBody;

  /// introFeatureTunnelTitle
  String get introFeatureTunnelTitle;

  /// introFooter
  String get introFooter;

  /// introGetStarted
  String get introGetStarted;

  /// introHeadline
  String get introHeadline;

  /// introMeaning
  String get introMeaning;

  /// introSegaro
  String get introSegaro;

  /// introSlogan
  String get introSlogan;

  /// introYousef
  String get introYousef;

  /// ipDual
  String get ipDual;

  /// ipV4
  String get ipV4;

  /// ipV6
  String get ipV6;

  /// ipVersion
  String get ipVersion;

  /// language
  String get language;

  /// licenceActivate
  String get licenceActivate;

  /// licenceDaysLeft
  String get licenceDaysLeft;

  /// licenceEnterCode
  String get licenceEnterCode;

  /// licenceEntryTitle
  String get licenceEntryTitle;

  /// licenceExpired
  String get licenceExpired;

  /// licenceExpiredTitle
  String get licenceExpiredTitle;

  /// licenceInvalid
  String get licenceInvalid;

  /// licencePlaceholder
  String get licencePlaceholder;

  /// licenceSubtitle
  String get licenceSubtitle;

  /// licenceTitle
  String get licenceTitle;

  /// locationUnknown
  String get locationUnknown;

  /// logLevel
  String get logLevel;

  /// logLevelDebug
  String get logLevelDebug;

  /// logLevelError
  String get logLevelError;

  /// logLevelInfo
  String get logLevelInfo;

  /// logLevelTrace
  String get logLevelTrace;

  /// logLevelWarn
  String get logLevelWarn;

  /// logs
  String get logs;

  /// logsAll
  String get logsAll;

  /// logsCopied
  String get logsCopied;

  /// logsEmpty
  String get logsEmpty;

  /// logsFilterEmpty
  String get logsFilterEmpty;

  /// logsLive
  String get logsLive;

  /// logsSourceAether
  String get logsSourceAether;

  /// logsSourceHev
  String get logsSourceHev;

  /// mapAttribution
  String get mapAttribution;

  /// mapExit
  String get mapExit;

  /// mapYou
  String get mapYou;

  /// memorialBody
  String get memorialBody;

  /// memorialTitle
  String get memorialTitle;

  /// memorialVow
  String get memorialVow;

  /// metricDownload
  String get metricDownload;

  /// metricSocks
  String get metricSocks;

  /// metricUpload
  String get metricUpload;

  /// notificationChannelDesc
  String get notificationChannelDesc;

  /// notificationChannelName
  String get notificationChannelName;

  /// notificationConnected
  String get notificationConnected;

  /// notificationConnecting
  String get notificationConnecting;

  /// notificationDisconnect
  String get notificationDisconnect;

  /// notificationPermissionBody
  String get notificationPermissionBody;

  /// notificationPermissionTitle
  String get notificationPermissionTitle;

  /// notificationTitle
  String get notificationTitle;

  /// obfuscation
  String get obfuscation;

  /// obfuscationAggressive
  String get obfuscationAggressive;

  /// obfuscationBalanced
  String get obfuscationBalanced;

  /// obfuscationLight
  String get obfuscationLight;

  /// obfuscationOff
  String get obfuscationOff;

  /// perfAuto
  String get perfAuto;

  /// perfHigh
  String get perfHigh;

  /// perfLow
  String get perfLow;

  /// perfMedium
  String get perfMedium;

  /// perfProfile
  String get perfProfile;

  /// perfProfileDesc
  String get perfProfileDesc;

  /// protocol
  String get protocol;

  /// protocolGool
  String get protocolGool;

  /// protocolGoolDesc
  String get protocolGoolDesc;

  /// protocolMasque
  String get protocolMasque;

  /// protocolMasqueDesc
  String get protocolMasqueDesc;

  /// protocolWireGuard
  String get protocolWireGuard;

  /// protocolWireGuardDesc
  String get protocolWireGuardDesc;

  /// proxyOnly
  String get proxyOnly;

  /// proxyOnlyDesc
  String get proxyOnlyDesc;

  /// quickReconnect
  String get quickReconnect;

  /// quickReconnectDesc
  String get quickReconnectDesc;

  /// rangeHint
  String get rangeHint;

  /// reconnectSeconds
  String get reconnectSeconds;

  /// reconnectSecondsDesc
  String get reconnectSecondsDesc;

  /// releaseToConnect
  String get releaseToConnect;

  /// resetConfirmBody
  String get resetConfirmBody;

  /// resetConfirmTitle
  String get resetConfirmTitle;

  /// resetSettings
  String get resetSettings;

  /// resetSettingsDesc
  String get resetSettingsDesc;

  /// retryAction
  String get retryAction;

  /// routingMode
  String get routingMode;

  /// routingSocks
  String get routingSocks;

  /// routingSocksDesc
  String get routingSocksDesc;

  /// routingSystem
  String get routingSystem;

  /// routingSystemDesc
  String get routingSystemDesc;

  /// routingTunnelDesc
  String get routingTunnelDesc;

  /// routingTunnelDescMobile
  String get routingTunnelDescMobile;

  /// ruleBlock
  String get ruleBlock;

  /// ruleBlockDesc
  String get ruleBlockDesc;

  /// ruleDirect
  String get ruleDirect;

  /// ruleDirectDesc
  String get ruleDirectDesc;

  /// ruleHint
  String get ruleHint;

  /// ruleNone
  String get ruleNone;

  /// save
  String get save;

  /// scanBalanced
  String get scanBalanced;

  /// scanBalancedDesc
  String get scanBalancedDesc;

  /// scanIronclad
  String get scanIronclad;

  /// scanIroncladDesc
  String get scanIroncladDesc;

  /// scanMode
  String get scanMode;

  /// scanStealth
  String get scanStealth;

  /// scanStealthDesc
  String get scanStealthDesc;

  /// scanThorough
  String get scanThorough;

  /// scanThoroughDesc
  String get scanThoroughDesc;

  /// scanTurbo
  String get scanTurbo;

  /// scanTurboDesc
  String get scanTurboDesc;

  /// scannerOff
  String get scannerOff;

  /// searchApps
  String get searchApps;

  /// sectionAdvanced
  String get sectionAdvanced;

  /// sectionApp
  String get sectionApp;

  /// sectionCore
  String get sectionCore;

  /// sectionDevice
  String get sectionDevice;

  /// sectionDeviceTunnel
  String get sectionDeviceTunnel;

  /// sectionNetwork
  String get sectionNetwork;

  /// sectionReliability
  String get sectionReliability;

  /// sectionRules
  String get sectionRules;

  /// sectionTls
  String get sectionTls;

  /// settings
  String get settings;

  /// settingsSubtitle
  String get settingsSubtitle;

  /// showSystemApps
  String get showSystemApps;

  /// sinceLabel
  String get sinceLabel;

  /// slideToConnect
  String get slideToConnect;

  /// socksPort
  String get socksPort;

  /// socksPortDesc
  String get socksPortDesc;

  /// splitBypassCount
  String get splitBypassCount;

  /// splitHeaderSubtitle
  String get splitHeaderSubtitle;

  /// splitTunnel
  String get splitTunnel;

  /// splitTunnelBlacklist
  String get splitTunnelBlacklist;

  /// splitTunnelBlacklistDesc
  String get splitTunnelBlacklistDesc;

  /// splitTunnelDesc
  String get splitTunnelDesc;

  /// splitTunnelDisabled
  String get splitTunnelDisabled;

  /// splitTunnelDisabledDesc
  String get splitTunnelDisabledDesc;

  /// stateConnected
  String get stateConnected;

  /// stateConnecting
  String get stateConnecting;

  /// stateDisconnected
  String get stateDisconnected;

  /// stateDisconnecting
  String get stateDisconnecting;

  /// stateFailed
  String get stateFailed;

  /// stateValidating
  String get stateValidating;

  /// supportChannel
  String get supportChannel;

  /// supportLabel
  String get supportLabel;

  /// switchOff
  String get switchOff;

  /// switchOn
  String get switchOn;

  /// tabHome
  String get tabHome;

  /// tapToConnect
  String get tapToConnect;

  /// tapToDisconnect
  String get tapToDisconnect;

  /// theme
  String get theme;

  /// themeDark
  String get themeDark;

  /// themeLight
  String get themeLight;

  /// themeSystem
  String get themeSystem;

  /// tlsGroups
  String get tlsGroups;

  /// tlsGroupsDesc
  String get tlsGroupsDesc;

  /// trafficUnprotected
  String get trafficUnprotected;

  /// transport
  String get transport;

  /// transportH2
  String get transportH2;

  /// transportH2Desc
  String get transportH2Desc;

  /// transportH3
  String get transportH3;

  /// transportH3Desc
  String get transportH3Desc;

  /// transportUdp
  String get transportUdp;

  /// transportWiw
  String get transportWiw;

  /// trayHide
  String get trayHide;

  /// trayQuit
  String get trayQuit;

  /// trayShow
  String get trayShow;

  /// trayStageActive
  String get trayStageActive;

  /// trayStageBusy
  String get trayStageBusy;

  /// trayStageIdle
  String get trayStageIdle;

  /// tunnelDegraded
  String get tunnelDegraded;

  /// tunnelDegradedHint
  String get tunnelDegradedHint;

  /// tunnelDeviceEmbedded
  String get tunnelDeviceEmbedded;

  /// tunnelDeviceMissing
  String get tunnelDeviceMissing;

  /// tunnelDeviceState
  String get tunnelDeviceState;

  /// tunnelInterface
  String get tunnelInterface;

  /// tunnelInterfaceDesc
  String get tunnelInterfaceDesc;

  /// tunnelModeActive
  String get tunnelModeActive;

  /// tunnelModeProxy
  String get tunnelModeProxy;

  /// tunnelModeSection
  String get tunnelModeSection;

  /// tunnelMtu
  String get tunnelMtu;

  /// tunnelMtuDesc
  String get tunnelMtuDesc;

  /// tunnelNeedsPrivileges
  String get tunnelNeedsPrivileges;

  /// tunnelReady
  String get tunnelReady;

  /// unitPort
  String get unitPort;

  /// uploaded
  String get uploaded;

  /// validateSeconds
  String get validateSeconds;

  /// validateSecondsDesc
  String get validateSecondsDesc;

  /// vpnPermissionDenied
  String get vpnPermissionDenied;

  /// vpnPermissionNeeded
  String get vpnPermissionNeeded;

  /// wgEndpoint
  String get wgEndpoint;

  /// wgEndpointDesc
  String get wgEndpointDesc;

  /// wgKeepalive
  String get wgKeepalive;

  /// wgKeepaliveDesc
  String get wgKeepaliveDesc;

  /// wgProfileRetry
  String get wgProfileRetry;

  /// wgProfileRetryDesc
  String get wgProfileRetryDesc;

  /// yourLocation
  String get yourLocation;

  /// zeroTrust
  String get zeroTrust;

  /// zeroTrustClear
  String get zeroTrustClear;

  /// zeroTrustClientId
  String get zeroTrustClientId;

  /// zeroTrustClientSecret
  String get zeroTrustClientSecret;

  /// zeroTrustCodeBody
  String get zeroTrustCodeBody;

  /// zeroTrustCodeLost
  String get zeroTrustCodeLost;

  /// zeroTrustCodePlaceholder
  String get zeroTrustCodePlaceholder;

  /// zeroTrustCodeRetry
  String get zeroTrustCodeRetry;

  /// zeroTrustCodeSend
  String get zeroTrustCodeSend;

  /// zeroTrustCodeTitle
  String get zeroTrustCodeTitle;

  /// zeroTrustDesc
  String get zeroTrustDesc;

  /// zeroTrustEmail
  String get zeroTrustEmail;

  /// zeroTrustEmailDesc
  String get zeroTrustEmailDesc;

  /// zeroTrustGateway
  String get zeroTrustGateway;

  /// zeroTrustGatewayDesc
  String get zeroTrustGatewayDesc;

  /// zeroTrustNeedsToken
  String get zeroTrustNeedsToken;

  /// zeroTrustOff
  String get zeroTrustOff;

  /// zeroTrustReady
  String get zeroTrustReady;

  /// zeroTrustServiceToken
  String get zeroTrustServiceToken;

  /// zeroTrustSet
  String get zeroTrustSet;

  /// zeroTrustSignIn
  String get zeroTrustSignIn;

  /// zeroTrustTeam
  String get zeroTrustTeam;

  /// zeroTrustTeamDesc
  String get zeroTrustTeamDesc;

  /// zeroTrustToken
  String get zeroTrustToken;

  /// zeroTrustTokenDesc
  String get zeroTrustTokenDesc;
}
