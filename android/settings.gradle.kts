pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.0.1" apply false
    id("org.jetbrains.kotlin.android") version "2.3.20" apply false
}

// mapbox_maps_flutter 3.34.2 assumes AGP 9 built-in Kotlin, but Flutter
// disables it (android.builtInKotlin=false). Apply the standalone Kotlin
// plugin to that subproject so its `kotlin { }` block resolves.
gradle.beforeProject {
    if (name == "mapbox_maps_flutter_mobile") {
        pluginManager.apply("org.jetbrains.kotlin.android")
    }
}

include(":app")
