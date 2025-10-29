plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.neura"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8  // Downgrade từ 11 xuống 1_8 cho tương thích desugaring
        targetCompatibility = JavaVersion.VERSION_1_8
        // Enable core library desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "1.8"  // Downgrade từ 11 xuống 1.8 cho tương thích
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID[](https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.neura"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        // Enable MultiDex nếu minSdk <=20 (an toàn cho Flutter)
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core library desugaring (cho AGP 7.4+)
   coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    
    // MultiDex support (nếu minSdk <=20)
    implementation("androidx.multidex:multidex:2.0.1")
}