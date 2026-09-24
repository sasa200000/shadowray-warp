-keep class org.bepass.oblivion.vpn.TProxyService { *; }
-keepclasseswithmembernames class * {
    native <methods>;
}
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# pointycastle (RSA licence verification) reflects into its own internals.
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**
-keep class com.sasavpn.** { *; }
