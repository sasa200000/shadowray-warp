import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @appName.
  ///
  /// **SasaVPN**
  String get appName;

  /// No description provided for @appDisplayName.
  ///
  /// **SasaVPN**
  String get appDisplayName;

  /// No description provided for @appTagline.
  ///
  /// **Internet for all, or no one**
  String get appTagline;

  /// No description provided for @introMeaning.
  ///
  /// **Means \"unawareness, ignorance\"**
  String get introMeaning;

  /// No description provided for @introCredit.
  ///
  /// **Built through the efforts of #Yousef_Ghobadi and dozens of known and anonymous activists, so that free access to the internet belongs to everyone.**
  String get introCredit;

  /// No description provided for @memorialTitle.
  ///
  /// **In memory of those killed on 18 and 19 Dey**
  String get memorialTitle;

  /// No description provided for @memorialBody.
  ///
  /// **Unarmed people, shot dead by the forces of the Islamic Republic**
  String get memorialBody;

  /// No description provided for @memorialVow.
  ///
  /// **We will not forgive, we will not forget**
  String get memorialVow;

  /// No description provided for @introSegaro.
  ///
  /// **#Segaro**
  String get introSegaro;

  /// No description provided for @introYousef.
  ///
  /// **#Yousef_Ghobadi**
  String get introYousef;

  /// No description provided for @introContinue.
  ///
  /// **Continue**
  String get introContinue;

  /// No description provided for @stateDisconnected.
  ///
  /// **Not connected**
  String get stateDisconnected;

  /// No description provided for @stateConnecting.
  ///
  /// **Connecting**
  String get stateConnecting;

  /// No description provided for @stateValidating.
  ///
  /// **Validating tunnel**
  String get stateValidating;

  /// No description provided for @stateConnected.
  ///
  /// **Connected**
  String get stateConnected;

  /// No description provided for @stateDisconnecting.
  ///
  /// **Disconnecting**
  String get stateDisconnecting;

  /// No description provided for @stateFailed.
  ///
  /// **Connection failed**
  String get stateFailed;

  /// No description provided for @tapToConnect.
  ///
  /// **Tap to connect**
  String get tapToConnect;

  /// No description provided for @tapToDisconnect.
  ///
  /// **Tap to disconnect**
  String get tapToDisconnect;

  /// No description provided for @yourLocation.
  ///
  /// **Your location**
  String get yourLocation;

  /// No description provided for @exitLocation.
  ///
  /// **Exit location**
  String get exitLocation;

  /// No description provided for @detectingLocation.
  ///
  /// **Detecting location**
  String get detectingLocation;

  /// No description provided for @locationUnknown.
  ///
  /// **Unknown**
  String get locationUnknown;

  /// No description provided for @uploaded.
  ///
  /// **Uploaded**
  String get uploaded;

  /// No description provided for @downloaded.
  ///
  /// **Downloaded**
  String get downloaded;

  /// No description provided for @duration.
  ///
  /// **Duration**
  String get duration;

  /// No description provided for @protocol.
  ///
  /// **Protocol**
  String get protocol;

  /// No description provided for @settings.
  ///
  /// **Settings**
  String get settings;

  /// No description provided for @logs.
  ///
  /// **Logs**
  String get logs;

  /// No description provided for @about.
  ///
  /// **About**
  String get about;

  /// No description provided for @language.
  ///
  /// **Language**
  String get language;

  /// No description provided for @theme.
  ///
  /// **Theme**
  String get theme;

  /// No description provided for @themeDark.
  ///
  /// **Dark**
  String get themeDark;

  /// No description provided for @themeLight.
  ///
  /// **Light**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// **System**
  String get themeSystem;

  /// No description provided for @sectionCore.
  ///
  /// **Core**
  String get sectionCore;

  /// No description provided for @sectionNetwork.
  ///
  /// **Network**
  String get sectionNetwork;

  /// No description provided for @sectionAdvanced.
  ///
  /// **Advanced**
  String get sectionAdvanced;

  /// No description provided for @routingTunnelDescMobile.
  ///
  /// **Routes all device traffic through the tunnel**
  String get routingTunnelDescMobile;

  /// No description provided for @tunnelDegraded.
  ///
  /// **Only the local proxy is up, device traffic is not going through the tunnel**
  String get tunnelDegraded;

  /// No description provided for @tunnelDegradedHint.
  ///
  /// **Full tunnel mode needs the app to run with administrator rights**
  String get tunnelDegradedHint;

  /// No description provided for @zeroTrust.
  ///
  /// **Organization account**
  String get zeroTrust;

  /// No description provided for @zeroTrustDesc.
  ///
  /// **Connect with a Cloudflare Zero Trust account instead of a personal one**
  String get zeroTrustDesc;

  /// No description provided for @zeroTrustOff.
  ///
  /// **Off**
  String get zeroTrustOff;

  /// No description provided for @zeroTrustTeam.
  ///
  /// **Team name**
  String get zeroTrustTeam;

  /// No description provided for @zeroTrustTeamDesc.
  ///
  /// **The name in your <team>.cloudflareaccess.com address**
  String get zeroTrustTeamDesc;

  /// No description provided for @zeroTrustToken.
  ///
  /// **Login token**
  String get zeroTrustToken;

  /// No description provided for @zeroTrustTokenDesc.
  ///
  /// **Sign in at <team>.cloudflareaccess.com/warp in a browser and paste the token here**
  String get zeroTrustTokenDesc;

  /// No description provided for @zeroTrustServiceToken.
  ///
  /// **Service token**
  String get zeroTrustServiceToken;

  /// No description provided for @zeroTrustClientId.
  ///
  /// **Client ID**
  String get zeroTrustClientId;

  /// No description provided for @zeroTrustClientSecret.
  ///
  /// **Client secret**
  String get zeroTrustClientSecret;

  /// No description provided for @zeroTrustGateway.
  ///
  /// **Send traffic through the organization gateway**
  String get zeroTrustGateway;

  /// No description provided for @zeroTrustGatewayDesc.
  ///
  /// **The organization's filtering and logging apply. It adds a hop inside the tunnel and your browsing is recorded.**
  String get zeroTrustGatewayDesc;

  /// No description provided for @zeroTrustReady.
  ///
  /// **Ready to connect**
  String get zeroTrustReady;

  /// No description provided for @zeroTrustNeedsToken.
  ///
  /// **Add an email address, a login token or a service token**
  String get zeroTrustNeedsToken;

  /// No description provided for @zeroTrustSet.
  ///
  /// **Set**
  String get zeroTrustSet;

  /// No description provided for @zeroTrustClear.
  ///
  /// **Clear the organization account**
  String get zeroTrustClear;

  /// No description provided for @zeroTrustEmail.
  ///
  /// **Email address**
  String get zeroTrustEmail;

  /// No description provided for @zeroTrustEmailDesc.
  ///
  /// **The simplest way in. Cloudflare emails a one-time code when you connect, and the app asks you for it.**
  String get zeroTrustEmailDesc;

  /// No description provided for @zeroTrustSignIn.
  ///
  /// **How you sign in**
  String get zeroTrustSignIn;

  /// No description provided for @zeroTrustCodeTitle.
  ///
  /// **Login code**
  String get zeroTrustCodeTitle;

  /// No description provided for @zeroTrustCodeBody.
  ///
  /// **A code was emailed to {email}. Enter it to finish signing in.**
  String get zeroTrustCodeBody;

  /// No description provided for @zeroTrustCodeRetry.
  ///
  /// **That code was not accepted. Check your mailbox and try again.**
  String get zeroTrustCodeRetry;

  /// No description provided for @zeroTrustCodePlaceholder.
  ///
  /// **Code from the email**
  String get zeroTrustCodePlaceholder;

  /// No description provided for @zeroTrustCodeSend.
  ///
  /// **Sign in**
  String get zeroTrustCodeSend;

  /// No description provided for @zeroTrustCodeLost.
  ///
  /// **The core is no longer waiting for a code**
  String get zeroTrustCodeLost;

  /// No description provided for @notificationConnected.
  ///
  /// **Tunnel active**
  String get notificationConnected;

  /// No description provided for @notificationConnecting.
  ///
  /// **Establishing tunnel**
  String get notificationConnecting;

  /// No description provided for @notificationDisconnect.
  ///
  /// **Disconnect**
  String get notificationDisconnect;

  /// No description provided for @sectionRules.
  ///
  /// **Where traffic goes**
  String get sectionRules;

  /// No description provided for @advancedDesc.
  ///
  /// **DNS, port, traffic rules and finer settings**
  String get advancedDesc;

  /// No description provided for @ruleBlock.
  ///
  /// **Blocked sites**
  String get ruleBlock;

  /// No description provided for @ruleBlockDesc.
  ///
  /// **These addresses are not allowed to open**
  String get ruleBlockDesc;

  /// No description provided for @ruleDirect.
  ///
  /// **Skip the tunnel**
  String get ruleDirect;

  /// No description provided for @ruleDirectDesc.
  ///
  /// **These open through your own connection instead of the tunnel**
  String get ruleDirectDesc;

  /// No description provided for @ruleNone.
  ///
  /// **Empty**
  String get ruleNone;

  /// No description provided for @ruleHint.
  ///
  /// **One address per line. A site name, an IP address or a port number all work.**
  String get ruleHint;

  /// No description provided for @sectionApp.
  ///
  /// **App**
  String get sectionApp;

  /// No description provided for @protocolMasque.
  ///
  /// **MASQUE**
  String get protocolMasque;

  /// No description provided for @protocolMasqueDesc.
  ///
  /// **Modern QUIC/HTTP-3 transport, best on healthy networks**
  String get protocolMasqueDesc;

  /// No description provided for @protocolWireGuard.
  ///
  /// **WireGuard**
  String get protocolWireGuard;

  /// No description provided for @protocolWireGuardDesc.
  ///
  /// **Classic WARP tunnel, lowest overhead**
  String get protocolWireGuardDesc;

  /// No description provided for @protocolGool.
  ///
  /// **Gool**
  String get protocolGool;

  /// No description provided for @protocolGoolDesc.
  ///
  /// **WARP inside WARP, slower but harder to block**
  String get protocolGoolDesc;

  /// No description provided for @transport.
  ///
  /// **Connection type**
  String get transport;

  /// No description provided for @transportH3.
  ///
  /// **HTTP/3 over QUIC**
  String get transportH3;

  /// No description provided for @transportH3Desc.
  ///
  /// **Faster, but your network has to leave UDP open**
  String get transportH3Desc;

  /// No description provided for @transportH2.
  ///
  /// **HTTP/2 over TCP**
  String get transportH2;

  /// No description provided for @transportH2Desc.
  ///
  /// **Looks like an ordinary website. Pick this when UDP is blocked**
  String get transportH2Desc;

  /// No description provided for @scanMode.
  ///
  /// **Scan mode**
  String get scanMode;

  /// No description provided for @scanTurbo.
  ///
  /// **Turbo**
  String get scanTurbo;

  /// No description provided for @scanTurboDesc.
  ///
  /// **Fast, takes the first working gateway**
  String get scanTurboDesc;

  /// No description provided for @scanBalanced.
  ///
  /// **Balanced**
  String get scanBalanced;

  /// No description provided for @scanBalancedDesc.
  ///
  /// **Reasonable speed and reliability**
  String get scanBalancedDesc;

  /// No description provided for @scanThorough.
  ///
  /// **Thorough**
  String get scanThorough;

  /// No description provided for @scanThoroughDesc.
  ///
  /// **Deeper search, picks the lowest latency**
  String get scanThoroughDesc;

  /// No description provided for @scanStealth.
  ///
  /// **Stealth**
  String get scanStealth;

  /// No description provided for @scanStealthDesc.
  ///
  /// **Quiet and patient, less traffic noise**
  String get scanStealthDesc;

  /// No description provided for @scanIronclad.
  ///
  /// **Ironclad**
  String get scanIronclad;

  /// No description provided for @scanIroncladDesc.
  ///
  /// **Opens a real tunnel and runs a real HTTP check per candidate**
  String get scanIroncladDesc;

  /// No description provided for @obfuscation.
  ///
  /// **Obfuscation**
  String get obfuscation;

  /// No description provided for @obfuscationOff.
  ///
  /// **Off**
  String get obfuscationOff;

  /// No description provided for @obfuscationLight.
  ///
  /// **Light**
  String get obfuscationLight;

  /// No description provided for @obfuscationBalanced.
  ///
  /// **Balanced**
  String get obfuscationBalanced;

  /// No description provided for @obfuscationAggressive.
  ///
  /// **Aggressive**
  String get obfuscationAggressive;

  /// No description provided for @endpoint.
  ///
  /// **Server**
  String get endpoint;

  /// No description provided for @endpointDesc.
  ///
  /// **Type a server if you want a specific one, or leave it empty and it will find one**
  String get endpointDesc;

  /// No description provided for @endpointAuto.
  ///
  /// **Automatic**
  String get endpointAuto;

  /// No description provided for @ipVersion.
  ///
  /// **IP version**
  String get ipVersion;

  /// No description provided for @ipV4.
  ///
  /// **IPv4**
  String get ipV4;

  /// No description provided for @ipV6.
  ///
  /// **IPv6**
  String get ipV6;

  /// No description provided for @ipDual.
  ///
  /// **Both**
  String get ipDual;

  /// No description provided for @socksPort.
  ///
  /// **SOCKS5 port**
  String get socksPort;

  /// No description provided for @socksPortDesc.
  ///
  /// **Local port the core listens on**
  String get socksPortDesc;

  /// No description provided for @allowLan.
  ///
  /// **Allow LAN access**
  String get allowLan;

  /// No description provided for @allowLanDesc.
  ///
  /// **Let other devices on your network use this proxy**
  String get allowLanDesc;

  /// No description provided for @proxyOnly.
  ///
  /// **Proxy only mode**
  String get proxyOnly;

  /// No description provided for @proxyOnlyDesc.
  ///
  /// **Expose SOCKS5 without capturing device traffic**
  String get proxyOnlyDesc;

  /// No description provided for @splitTunnel.
  ///
  /// **Split tunneling**
  String get splitTunnel;

  /// No description provided for @splitTunnelDesc.
  ///
  /// **Choose which apps bypass the tunnel**
  String get splitTunnelDesc;

  /// No description provided for @splitTunnelDisabled.
  ///
  /// **Disabled**
  String get splitTunnelDisabled;

  /// No description provided for @splitTunnelDisabledDesc.
  ///
  /// **All app traffic goes through the tunnel**
  String get splitTunnelDisabledDesc;

  /// No description provided for @splitTunnelBlacklist.
  ///
  /// **Bypass selected**
  String get splitTunnelBlacklist;

  /// No description provided for @splitTunnelBlacklistDesc.
  ///
  /// **Selected apps skip the tunnel**
  String get splitTunnelBlacklistDesc;

  /// No description provided for @showSystemApps.
  ///
  /// **Show system apps**
  String get showSystemApps;

  /// No description provided for @searchApps.
  ///
  /// **Search apps**
  String get searchApps;

  /// No description provided for @fragment.
  ///
  /// **Send in pieces**
  String get fragment;

  /// No description provided for @fragmentDesc.
  ///
  /// **Breaks the start of the connection into pieces so filtering cannot recognise it**
  String get fragmentDesc;

  /// No description provided for @logLevel.
  ///
  /// **Log level**
  String get logLevel;

  /// No description provided for @logLevelError.
  ///
  /// **Error**
  String get logLevelError;

  /// No description provided for @logLevelWarn.
  ///
  /// **Warning**
  String get logLevelWarn;

  /// No description provided for @logLevelInfo.
  ///
  /// **Info**
  String get logLevelInfo;

  /// No description provided for @logLevelDebug.
  ///
  /// **Debug**
  String get logLevelDebug;

  /// No description provided for @logLevelTrace.
  ///
  /// **Trace**
  String get logLevelTrace;

  /// No description provided for @perfProfile.
  ///
  /// **Performance profile**
  String get perfProfile;

  /// No description provided for @perfProfileDesc.
  ///
  /// **How much CPU and memory the core may use**
  String get perfProfileDesc;

  /// No description provided for @perfAuto.
  ///
  /// **Automatic**
  String get perfAuto;

  /// No description provided for @perfLow.
  ///
  /// **Low**
  String get perfLow;

  /// No description provided for @perfMedium.
  ///
  /// **Medium**
  String get perfMedium;

  /// No description provided for @perfHigh.
  ///
  /// **High**
  String get perfHigh;

  /// No description provided for @quickReconnect.
  ///
  /// **Quick reconnect**
  String get quickReconnect;

  /// No description provided for @quickReconnectDesc.
  ///
  /// **Retry the last working gateway before a full rescan**
  String get quickReconnectDesc;

  /// No description provided for @resetSettings.
  ///
  /// **Reset settings**
  String get resetSettings;

  /// No description provided for @resetSettingsDesc.
  ///
  /// **Return everything to defaults**
  String get resetSettingsDesc;

  /// No description provided for @resetConfirmTitle.
  ///
  /// **Reset settings?**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmBody.
  ///
  /// **All preferences go back to their default values. Your saved identity is kept.**
  String get resetConfirmBody;

  /// No description provided for @cancel.
  ///
  /// **Cancel**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// **Confirm**
  String get confirm;

  /// No description provided for @save.
  ///
  /// **Save**
  String get save;

  /// No description provided for @copyLogs.
  ///
  /// **Copy logs**
  String get copyLogs;

  /// No description provided for @clearLogs.
  ///
  /// **Clear logs**
  String get clearLogs;

  /// No description provided for @logsEmpty.
  ///
  /// **No logs yet. Connect once and they will show up here.**
  String get logsEmpty;

  /// No description provided for @copiedToClipboard.
  ///
  /// **Copied to clipboard**
  String get copiedToClipboard;

  /// No description provided for @aboutBody.
  ///
  /// **SasaVPN connects you to the internet through Cloudflare WARP. The tunnel engine is the open source Aether core, which routes traffic over MASQUE and WireGuard.**
  String get aboutBody;

  /// No description provided for @aboutCore.
  ///
  /// **Core engine**
  String get aboutCore;

  /// No description provided for @aboutVersion.
  ///
  /// **Version**
  String get aboutVersion;

  /// No description provided for @aboutSource.
  ///
  /// **Source code**
  String get aboutSource;

  /// No description provided for @aboutLicense.
  ///
  /// **License**
  String get aboutLicense;

  /// No description provided for @vpnPermissionNeeded.
  ///
  /// **VPN permission is required to route your traffic**
  String get vpnPermissionNeeded;

  /// No description provided for @vpnPermissionDenied.
  ///
  /// **Permission denied, the tunnel cannot start**
  String get vpnPermissionDenied;

  /// No description provided for @connectionFailedRetry.
  ///
  /// **Could not establish a tunnel. Try another protocol or scan mode.**
  String get connectionFailedRetry;

  /// No description provided for @exitConfirm.
  ///
  /// **Press back again to exit**
  String get exitConfirm;

  /// No description provided for @notificationTitle.
  ///
  /// **ShadowRay**
  String get notificationTitle;

  /// No description provided for @mapAttribution.
  ///
  /// **Map data by OpenStreetMap contributors**
  String get mapAttribution;

  /// No description provided for @sectionTls.
  ///
  /// **TLS and camouflage**
  String get sectionTls;

  /// No description provided for @sectionReliability.
  ///
  /// **Reliability**
  String get sectionReliability;

  /// No description provided for @wgEndpoint.
  ///
  /// **WireGuard server**
  String get wgEndpoint;

  /// No description provided for @wgEndpointDesc.
  ///
  /// **Leave empty and it will pick one**
  String get wgEndpointDesc;

  /// No description provided for @h2Endpoint.
  ///
  /// **HTTP/2 server**
  String get h2Endpoint;

  /// No description provided for @h2EndpointDesc.
  ///
  /// **The server used in HTTP/2 mode**
  String get h2EndpointDesc;

  /// No description provided for @ech.
  ///
  /// **Hide the site name**
  String get ech;

  /// No description provided for @echDesc.
  ///
  /// **Keeps the name of the site you open hidden from the network**
  String get echDesc;

  /// No description provided for @fragmentSize.
  ///
  /// **Fragment size**
  String get fragmentSize;

  /// No description provided for @fragmentDelay.
  ///
  /// **Fragment delay**
  String get fragmentDelay;

  /// No description provided for @rangeHint.
  ///
  /// **A single number or a range such as 16-32**
  String get rangeHint;

  /// No description provided for @tlsGroups.
  ///
  /// **TLS key groups**
  String get tlsGroups;

  /// No description provided for @tlsGroupsDesc.
  ///
  /// **Key share groups offered during the handshake**
  String get tlsGroupsDesc;

  /// No description provided for @dataCheck.
  ///
  /// **Check data really flows**
  String get dataCheck;

  /// No description provided for @dataCheckDesc.
  ///
  /// **Do not say connected until real data has gone through**
  String get dataCheckDesc;

  /// No description provided for @validateSeconds.
  ///
  /// **Check timeout**
  String get validateSeconds;

  /// No description provided for @validateSecondsDesc.
  ///
  /// **How many seconds to wait before deciding the tunnel works**
  String get validateSecondsDesc;

  /// No description provided for @reconnectSeconds.
  ///
  /// **Reconnect delay**
  String get reconnectSeconds;

  /// No description provided for @reconnectSecondsDesc.
  ///
  /// **How long to wait after a drop before trying again**
  String get reconnectSecondsDesc;

  /// No description provided for @wgKeepalive.
  ///
  /// **Keep-alive interval**
  String get wgKeepalive;

  /// No description provided for @wgKeepaliveDesc.
  ///
  /// **Send a small packet every few seconds so the connection stays open**
  String get wgKeepaliveDesc;

  /// No description provided for @wgProfileRetry.
  ///
  /// **Retry other profiles**
  String get wgProfileRetry;

  /// No description provided for @wgProfileRetryDesc.
  ///
  /// **Try other obfuscation profiles while scanning**
  String get wgProfileRetryDesc;

  /// No description provided for @tabHome.
  ///
  /// **Shield**
  String get tabHome;

  /// No description provided for @slideToConnect.
  ///
  /// **Slide to connect**
  String get slideToConnect;

  /// No description provided for @releaseToConnect.
  ///
  /// **Release to connect**
  String get releaseToConnect;

  /// No description provided for @aboutApp.
  ///
  /// **App repository**
  String get aboutApp;

  /// No description provided for @aboutCoreRepo.
  ///
  /// **Core repository**
  String get aboutCoreRepo;

  /// No description provided for @aboutCredits.
  ///
  /// **Built on**
  String get aboutCredits;

  /// No description provided for @aboutFooter.
  ///
  /// **SasaVPN is built on ShadowRay. The tunnel engine is Aether by Cluvex Studio.**
  String get aboutFooter;

  /// No description provided for @connectAction.
  ///
  /// **Connect**
  String get connectAction;

  /// No description provided for @disconnectAction.
  ///
  /// **Disconnect**
  String get disconnectAction;

  /// No description provided for @retryAction.
  ///
  /// **Try again**
  String get retryAction;

  /// No description provided for @tunnelModeSection.
  ///
  /// **Tunnel device**
  String get tunnelModeSection;

  /// No description provided for @tunnelInterface.
  ///
  /// **Interface name**
  String get tunnelInterface;

  /// No description provided for @tunnelInterfaceDesc.
  ///
  /// **Name of the virtual network card**
  String get tunnelInterfaceDesc;

  /// No description provided for @tunnelMtu.
  ///
  /// **MTU**
  String get tunnelMtu;

  /// No description provided for @tunnelMtuDesc.
  ///
  /// **Packet size. Lower it if the connection feels slow**
  String get tunnelMtuDesc;

  /// No description provided for @tunnelDeviceState.
  ///
  /// **Device state**
  String get tunnelDeviceState;

  /// No description provided for @tunnelDeviceEmbedded.
  ///
  /// **Embedded**
  String get tunnelDeviceEmbedded;

  /// No description provided for @tunnelDeviceMissing.
  ///
  /// **Not embedded**
  String get tunnelDeviceMissing;

  /// No description provided for @tunnelNeedsPrivileges.
  ///
  /// **Needs elevated privileges**
  String get tunnelNeedsPrivileges;

  /// No description provided for @tunnelReady.
  ///
  /// **Ready**
  String get tunnelReady;

  /// No description provided for @tunnelModeActive.
  ///
  /// **Full device tunnel**
  String get tunnelModeActive;

  /// No description provided for @tunnelModeProxy.
  ///
  /// **Proxy only**
  String get tunnelModeProxy;

  /// No description provided for @logsAll.
  ///
  /// **All**
  String get logsAll;

  /// No description provided for @logsSourceAether.
  ///
  /// **Aether**
  String get logsSourceAether;

  /// No description provided for @logsSourceHev.
  ///
  /// **Tunnel**
  String get logsSourceHev;

  /// No description provided for @logsFilterEmpty.
  ///
  /// **Nothing found**
  String get logsFilterEmpty;

  /// No description provided for @logsCopied.
  ///
  /// **Copied to clipboard**
  String get logsCopied;

  /// No description provided for @introSlogan.
  ///
  /// **Internet for All, or No One**
  String get introSlogan;

  /// No description provided for @trayShow.
  ///
  /// **Show ShadowRay**
  String get trayShow;

  /// No description provided for @trayHide.
  ///
  /// **Hide to tray**
  String get trayHide;

  /// No description provided for @trayQuit.
  ///
  /// **Quit**
  String get trayQuit;

  /// No description provided for @trayStageIdle.
  ///
  /// **Disconnected**
  String get trayStageIdle;

  /// No description provided for @trayStageBusy.
  ///
  /// **Connecting**
  String get trayStageBusy;

  /// No description provided for @trayStageActive.
  ///
  /// **Connected**
  String get trayStageActive;

  /// No description provided for @fragmentNeedsHttp2.
  ///
  /// **Switches the transport to HTTP/2, the only one that carries a TLS ClientHello**
  String get fragmentNeedsHttp2;

  /// No description provided for @transportUdp.
  ///
  /// **UDP**
  String get transportUdp;

  /// No description provided for @transportWiw.
  ///
  /// **WARP in WARP**
  String get transportWiw;

  /// No description provided for @dnsOverride.
  ///
  /// **Tunnel the resolver**
  String get dnsOverride;

  /// No description provided for @dnsOverrideDesc.
  ///
  /// **Sends DNS through the tunnel instead of your ISP resolver**
  String get dnsOverrideDesc;

  /// No description provided for @dnsServers.
  ///
  /// **Resolver addresses**
  String get dnsServers;

  /// No description provided for @dnsServersDesc.
  ///
  /// **Used while the tunnel is up**
  String get dnsServersDesc;

  /// No description provided for @switchOff.
  ///
  /// **Off**
  String get switchOff;

  /// No description provided for @switchOn.
  ///
  /// **Secure**
  String get switchOn;

  /// No description provided for @chipFullTunnel.
  ///
  /// **Full tunnel**
  String get chipFullTunnel;

  /// No description provided for @chipProxyOnly.
  ///
  /// **Proxy only**
  String get chipProxyOnly;

  /// No description provided for @chipNotProtected.
  ///
  /// **Not protected**
  String get chipNotProtected;

  /// No description provided for @trafficUnprotected.
  ///
  /// **your traffic is not protected**
  String get trafficUnprotected;

  /// No description provided for @sinceLabel.
  ///
  /// **since {time}**
  String get sinceLabel;

  /// No description provided for @exitNode.
  ///
  /// **Exit node**
  String get exitNode;

  /// No description provided for @gatewayLabel.
  ///
  /// **Gateway**
  String get gatewayLabel;

  /// No description provided for @gatewayAutoHint.
  ///
  /// **Aether picks the fastest clean edge**
  String get gatewayAutoHint;

  /// No description provided for @metricDownload.
  ///
  /// **Download**
  String get metricDownload;

  /// No description provided for @metricUpload.
  ///
  /// **Upload**
  String get metricUpload;

  /// No description provided for @metricSocks.
  ///
  /// **SOCKS5**
  String get metricSocks;

  /// No description provided for @unitPort.
  ///
  /// **port**
  String get unitPort;

  /// No description provided for @mapYou.
  ///
  /// **You**
  String get mapYou;

  /// No description provided for @mapExit.
  ///
  /// **Exit**
  String get mapExit;

  /// No description provided for @settingsSubtitle.
  ///
  /// **Aether core · {version}**
  String get settingsSubtitle;

  /// No description provided for @fullTunnelDesc.
  ///
  /// **Route every app, not just the SOCKS5 port**
  String get fullTunnelDesc;

  /// No description provided for @sectionDeviceTunnel.
  ///
  /// **Device tunnel**
  String get sectionDeviceTunnel;

  /// No description provided for @sectionDevice.
  ///
  /// **Device**
  String get sectionDevice;

  /// No description provided for @logsLive.
  ///
  /// **live from the core**
  String get logsLive;

  /// No description provided for @aboutInMemory.
  ///
  /// **In memory of**
  String get aboutInMemory;

  /// No description provided for @aboutHev.
  ///
  /// **hev-socks5-tunnel**
  String get aboutHev;

  /// No description provided for @aboutHevDesc.
  ///
  /// **the tun device that carries your packets**
  String get aboutHevDesc;

  /// No description provided for @aboutAppSummary.
  ///
  /// **app {app} · core aether {core}**
  String get aboutAppSummary;

  /// No description provided for @introHeadline.
  ///
  /// **Private by default**
  String get introHeadline;

  /// No description provided for @introBody.
  ///
  /// **ShadowRay routes your traffic through the Aether core, so the network you are on cannot read or shape it.**
  String get introBody;

  /// No description provided for @introFeatureTunnelTitle.
  ///
  /// **MASQUE over QUIC**
  String get introFeatureTunnelTitle;

  /// No description provided for @introFeatureTunnelBody.
  ///
  /// **A tunnel that looks like ordinary HTTPS traffic.**
  String get introFeatureTunnelBody;

  /// No description provided for @introFeatureAccountTitle.
  ///
  /// **Nothing to sign up for**
  String get introFeatureAccountTitle;

  /// No description provided for @introFeatureAccountBody.
  ///
  /// **A dedicated identity is provisioned on first launch.**
  String get introFeatureAccountBody;

  /// No description provided for @introFeatureControlTitle.
  ///
  /// **Choose what goes through**
  String get introFeatureControlTitle;

  /// No description provided for @introFeatureControlBody.
  ///
  /// **Split tunnel, custom resolver, per protocol control.**
  String get introFeatureControlBody;

  /// No description provided for @introGetStarted.
  ///
  /// **Get started**
  String get introGetStarted;

  /// No description provided for @introFooter.
  ///
  /// **Free and open source · GPL-3.0**
  String get introFooter;

  /// No description provided for @splitHeaderSubtitle.
  ///
  /// **Apps listed here bypass the tunnel entirely**
  String get splitHeaderSubtitle;

  /// No description provided for @splitBypassCount.
  ///
  /// **{count} apps bypass the tunnel**
  String get splitBypassCount;

  /// No description provided for @apply.
  ///
  /// **Apply**
  String get apply;

  /// No description provided for @geoUnavailable.
  ///
  /// **location could not be detected**
  String get geoUnavailable;

  /// No description provided for @routingMode.
  ///
  /// **Routing mode**
  String get routingMode;

  /// No description provided for @routingSocks.
  ///
  /// **SOCKS5 only**
  String get routingSocks;

  /// No description provided for @routingSocksDesc.
  ///
  /// **Only apps you point at the local port go through the tunnel**
  String get routingSocksDesc;

  /// No description provided for @routingSystem.
  ///
  /// **System proxy**
  String get routingSystem;

  /// No description provided for @routingSystemDesc.
  ///
  /// **Sets the desktop proxy for every app, no admin rights needed**
  String get routingSystemDesc;

  /// No description provided for @routingTunnelDesc.
  ///
  /// **Routes every packet of the device, needs administrator rights**
  String get routingTunnelDesc;

  /// No description provided for @chipSystemProxy.
  ///
  /// **System proxy**
  String get chipSystemProxy;

  /// No description provided for @chipSocksOnly.
  ///
  /// **SOCKS only**
  String get chipSocksOnly;

  /// No description provided for @scannerOff.
  ///
  /// **Scanner off, your gateway is used directly**
  String get scannerOff;

  /// No description provided for @endpointManualHint.
  ///
  /// **Set a gateway to skip scanning entirely**
  String get endpointManualHint;

  /// No description provided for @notificationChannelName.
  ///
  /// **Tunnel status**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDesc.
  ///
  /// **Shows whether the tunnel is up and lets you disconnect**
  String get notificationChannelDesc;

  /// No description provided for @notificationPermissionTitle.
  ///
  /// **Allow notifications**
  String get notificationPermissionTitle;

  /// No description provided for @notificationPermissionBody.
  ///
  /// **ShadowRay needs a notification to keep the tunnel alive in the background**
  String get notificationPermissionBody;

  /// No description provided for @licenceTitle.
  ///
  /// **Subscription code**
  String get licenceTitle;

  /// No description provided for @licenceSubtitle.
  ///
  /// **Enter your subscription code to open the app**
  String get licenceSubtitle;

  /// No description provided for @licenceExpired.
  ///
  /// **Your subscription code has expired. Get a new one**
  String get licenceExpired;

  /// No description provided for @licenceEnterCode.
  ///
  /// **Enter your subscription code**
  String get licenceEnterCode;

  /// No description provided for @licencePlaceholder.
  ///
  /// **SASA-…**
  String get licencePlaceholder;

  /// No description provided for @licenceActivate.
  ///
  /// **Activate and continue**
  String get licenceActivate;

  /// No description provided for @licenceInvalid.
  ///
  /// **That subscription code is not valid**
  String get licenceInvalid;

  /// No description provided for @supportLabel.
  ///
  /// **Support**
  String get supportLabel;

  /// No description provided for @adminTitle.
  ///
  /// **Admin panel**
  String get adminTitle;

  /// No description provided for @adminLockPrompt.
  ///
  /// **Type the lock code to open the admin panel**
  String get adminLockPrompt;

  /// No description provided for @adminLockPlaceholder.
  ///
  /// **Lock code**
  String get adminLockPlaceholder;

  /// No description provided for @adminUnlock.
  ///
  /// **Unlock**
  String get adminUnlock;

  /// No description provided for @adminLockWrong.
  ///
  /// **Wrong lock code**
  String get adminLockWrong;

  /// No description provided for @adminLockTooShort.
  ///
  /// **The lock code must be at least 6 characters**
  String get adminLockTooShort;

  /// No description provided for @adminLockChanged.
  ///
  /// **Lock code changed**
  String get adminLockChanged;

  /// No description provided for @adminGenerate.
  ///
  /// **Generate a subscription code**
  String get adminGenerate;

  /// No description provided for @adminPlan.
  ///
  /// **Plan length**
  String get adminPlan;

  /// No description provided for @adminDevices.
  ///
  /// **Number of users (devices)**
  String get adminDevices;

  /// No description provided for @adminDeviceUnit.
  ///
  /// **user**
  String get adminDeviceUnit;

  /// No description provided for @adminGenerateButton.
  ///
  /// **Generate code**
  String get adminGenerateButton;

  /// No description provided for @adminCodeReady.
  ///
  /// **Code ready — copy it**
  String get adminCodeReady;

  /// No description provided for @adminHistory.
  ///
  /// **Codes you have generated**
  String get adminHistory;

  /// No description provided for @adminHistoryEmpty.
  ///
  /// **No codes generated yet**
  String get adminHistoryEmpty;

  /// No description provided for @adminChangeLock.
  ///
  /// **Change the panel lock code**
  String get adminChangeLock;

  /// No description provided for @adminNewLockPlaceholder.
  ///
  /// **New lock code**
  String get adminNewLockPlaceholder;

  /// No description provided for @adminChangeLockButton.
  ///
  /// **Change lock code**
  String get adminChangeLockButton;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<L10n> {
  const _AppLocalizationsDelegate();

  @override
  Future<L10n> load(Locale locale) {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());
    return SynchronousFuture<L10n>(getL10n(localeName));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

L10n getL10n(String localeName) {
  switch (localeName) {
    case 'en':
      return L10nEn();
    case 'fa':
      return L10nFa();
  }

  return L10nEn();
}
