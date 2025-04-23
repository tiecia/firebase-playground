{
  description = "Flutter 3.13.x";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, android-nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };
        android-sdk =  android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
          build-tools-35-0-0
          build-tools-34-0-0
          cmdline-tools-latest
          emulator
          platform-tools
          platforms-android-35
          platforms-android-34
          system-images-android-35-google-apis-x86-64
          ndk-26-3-11579264
          ndk-27-0-12077973
          cmake-3-22-1
        ]);
        chrome-variant = "chromium";
        chrome-pkg = pkgs.${chrome-variant};
        chrome-script = pkgs.writeShellScript "chrome-script" ''
          exec ${chrome-pkg}/bin/${chrome-variant} --use-gl=desktop "$@"
        '';
      in
      {
        devShell =
          pkgs.mkShell {
            ANDROID_SDK_ROOT = "${android-sdk}/libexec/android-sdk";
            ANDROID_HOME = "${android-sdk}/libexec/android-sdk";
            ANDROID_AVD_HOME = "/home/tiec/.config/.android/avd";
            CHROME_EXECUTABLE = "${chrome-script}";
            # GRADLE_USER_HOME = "/home/tiec/.gradle";
            # Flutter SDK needs to be writable because of: https://github.com/NixOS/nixpkgs/issues/395096
            FLUTTER_ROOT = "/home/tiec/.flutter-sdk/flutter";
            GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android-sdk}/share/android-sdk/build-tools/35.0.0/aapt2";
            buildInputs = [
              pkgs.flutter
              android-sdk
              pkgs.jdk17
              chrome-pkg
              pkgs.firebase-tools
            ];
          };
    });
}
