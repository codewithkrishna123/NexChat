#!/bin/bash

# ============================================================
# NexChat - Complete Android Project Generator
# Developed by Ankan | Ankan Corporation
# ============================================================

set -e

PROJECT_ROOT="NexChat"
PACKAGE_PATH="com/example/nexchat"
PACKAGE_NAME="com.example.nexchat"

echo "Creating NexChat Android project..."

# ============================================================
# DIRECTORY STRUCTURE
# ============================================================
mkdir -p "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/activities"
mkdir -p "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/fragments"
mkdir -p "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/adapters"
mkdir -p "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/models"
mkdir -p "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/services"
mkdir -p "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/webrtc"
mkdir -p "$PROJECT_ROOT/app/src/main/res/layout"
mkdir -p "$PROJECT_ROOT/app/src/main/res/menu"
mkdir -p "$PROJECT_ROOT/app/src/main/res/drawable"
mkdir -p "$PROJECT_ROOT/app/src/main/res/values"
mkdir -p "$PROJECT_ROOT/gradle/wrapper"

# ============================================================
# settings.gradle
# ============================================================
cat > "$PROJECT_ROOT/settings.gradle" << 'SETTINGS_EOF'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }
}
rootProject.name = "NexChat"
include ':app'
SETTINGS_EOF

# ============================================================
# root build.gradle
# ============================================================
cat > "$PROJECT_ROOT/build.gradle" << 'ROOT_BUILD_EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.0'
        classpath 'com.google.gms:google-services:4.4.0'
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
ROOT_BUILD_EOF

# ============================================================
# app/build.gradle
# ============================================================
cat > "$PROJECT_ROOT/app/build.gradle" << 'APP_BUILD_EOF'
plugins {
    id 'com.android.application'
    id 'com.google.gms.google-services'
}

android {
    namespace 'com.example.nexchat'
    compileSdk 34

    defaultConfig {
        applicationId "com.example.nexchat"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
        multiDexEnabled true
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    packagingOptions {
        exclude 'META-INF/DEPENDENCIES'
        exclude 'META-INF/LICENSE'
        exclude 'META-INF/LICENSE.txt'
        exclude 'META-INF/NOTICE'
        exclude 'META-INF/NOTICE.txt'
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.11.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    implementation 'androidx.recyclerview:recyclerview:1.3.2'
    implementation 'androidx.fragment:fragment:1.6.2'
    implementation 'androidx.multidex:multidex:2.0.1'

    // Firebase BOM
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.firebase:firebase-database'
    implementation 'com.google.firebase:firebase-messaging'

    // Google Sign-In
    implementation 'com.google.android.gms:play-services-auth:21.0.0'

    // WebRTC
    implementation 'io.getstream:stream-webrtc-android:1.1.2'

    // Glide for image loading
    implementation 'com.github.bumptech.glide:glide:4.16.0'
    annotationProcessor 'com.github.bumptech.glide:compiler:4.16.0'
}
APP_BUILD_EOF

# ============================================================
# gradle/wrapper/gradle-wrapper.properties
# ============================================================
cat > "$PROJECT_ROOT/gradle/wrapper/gradle-wrapper.properties" << 'GRADLE_WRAPPER_EOF'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.2-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
GRADLE_WRAPPER_EOF

# ============================================================
# gradlew stub
# ============================================================
cat > "$PROJECT_ROOT/gradlew" << 'GRADLEW_EOF'
#!/bin/sh
exec gradle "$@"
GRADLEW_EOF
chmod +x "$PROJECT_ROOT/gradlew"

# ============================================================
# proguard-rules.pro
# ============================================================
cat > "$PROJECT_ROOT/app/proguard-rules.pro" << 'PROGUARD_EOF'
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class io.getstream.** { *; }
-dontwarn io.getstream.**
PROGUARD_EOF

# ============================================================
# AndroidManifest.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/AndroidManifest.xml" << 'MANIFEST_EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.nexchat">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_CAMERA" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />

    <uses-feature android:name="android.hardware.camera" android:required="false" />
    <uses-feature android:name="android.hardware.camera.front" android:required="false" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.NexChat"
        android:name="androidx.multidex.MultiDexApplication">

        <!-- Splash / Login Activity -->
        <activity
            android:name=".activities.LoginActivity"
            android:exported="true"
            android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <!-- Main Activity -->
        <activity
            android:name=".activities.MainActivity"
            android:exported="false"
            android:screenOrientation="portrait" />

        <!-- Chat Activity -->
        <activity
            android:name=".activities.ChatActivity"
            android:exported="false"
            android:screenOrientation="portrait"
            android:windowSoftInputMode="stateVisible|adjustResize" />

        <!-- Call Activity -->
        <activity
            android:name=".activities.CallActivity"
            android:exported="false"
            android:screenOrientation="portrait" />

        <!-- Background Service -->
        <service
            android:name=".services.BackgroundService"
            android:enabled="true"
            android:exported="false"
            android:foregroundServiceType="microphone" />

        <!-- FCM Service -->
        <service
            android:name=".services.NexChatMessagingService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
        </service>

    </application>
</manifest>
MANIFEST_EOF

# ============================================================
# res/values/strings.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/values/strings.xml" << 'STRINGS_EOF'
<resources>
    <string name="app_name">NexChat</string>
    <string name="tab_chat">Chat</string>
    <string name="tab_calls">Calls</string>
    <string name="tab_friends">Friends</string>
    <string name="tab_settings">Settings</string>
    <string name="tab_developer">Developer</string>
    <string name="login_with_email">Login with Email</string>
    <string name="login_with_google">Login with Google</string>
    <string name="sign_up">Sign Up</string>
    <string name="email_hint">Email Address</string>
    <string name="password_hint">Password</string>
    <string name="send">Send</string>
    <string name="type_message">Type a message...</string>
    <string name="developer_info">NexChat\n\nDeveloped by Ankan\n\nCustom Messenger App with Chat &amp; Calling</string>
    <string name="notification_channel_name">NexChat Calls</string>
    <string name="listening_for_calls">Listening for calls</string>
</resources>
STRINGS_EOF

# ============================================================
# res/values/colors.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/values/colors.xml" << 'COLORS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="colorPrimary">#075E54</color>
    <color name="colorPrimaryDark">#054D44</color>
    <color name="colorAccent">#25D366</color>
    <color name="colorBackground">#ECE5DD</color>
    <color name="colorBubbleOutgoing">#DCF8C6</color>
    <color name="colorBubbleIncoming">#FFFFFF</color>
    <color name="colorWhite">#FFFFFF</color>
    <color name="colorTextPrimary">#111111</color>
    <color name="colorTextSecondary">#666666</color>
    <color name="colorDivider">#E0E0E0</color>
    <color name="colorToolbar">#075E54</color>
    <color name="colorCallGreen">#25D366</color>
    <color name="colorCallRed">#F44336</color>
    <color name="colorGrey">#808080</color>
    <color name="colorLightGrey">#F5F5F5</color>
    <color name="black">#FF000000</color>
    <color name="white">#FFFFFFFF</color>
</resources>
COLORS_EOF

# ============================================================
# res/values/themes.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/values/themes.xml" << 'THEMES_EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.NexChat" parent="Theme.MaterialComponents.Light.NoActionBar">
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryVariant">@color/colorPrimaryDark</item>
        <item name="colorOnPrimary">@color/colorWhite</item>
        <item name="colorSecondary">@color/colorAccent</item>
        <item name="colorOnSecondary">@color/colorWhite</item>
        <item name="android:statusBarColor">@color/colorPrimaryDark</item>
        <item name="android:navigationBarColor">@color/colorWhite</item>
    </style>

    <style name="Theme.NexChat.Login" parent="Theme.MaterialComponents.Light.NoActionBar">
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryVariant">@color/colorPrimaryDark</item>
        <item name="colorOnPrimary">@color/colorWhite</item>
        <item name="colorSecondary">@color/colorAccent</item>
        <item name="android:statusBarColor">@color/colorPrimary</item>
    </style>
</resources>
THEMES_EOF

# ============================================================
# res/values/dimens.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/values/dimens.xml" << 'DIMENS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <dimen name="bubble_padding">10dp</dimen>
    <dimen name="bubble_corner_radius">12dp</dimen>
    <dimen name="message_margin">8dp</dimen>
    <dimen name="toolbar_elevation">4dp</dimen>
</resources>
DIMENS_EOF

# ============================================================
# res/drawable/bubble_outgoing.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/bubble_outgoing.xml" << 'BUBBLE_OUT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <solid android:color="@color/colorBubbleOutgoing" />
    <corners
        android:topLeftRadius="12dp"
        android:topRightRadius="12dp"
        android:bottomLeftRadius="12dp"
        android:bottomRightRadius="2dp" />
    <padding
        android:left="10dp"
        android:top="8dp"
        android:right="10dp"
        android:bottom="8dp" />
</shape>
BUBBLE_OUT_EOF

# ============================================================
# res/drawable/bubble_incoming.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/bubble_incoming.xml" << 'BUBBLE_IN_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <solid android:color="@color/colorBubbleIncoming" />
    <corners
        android:topLeftRadius="2dp"
        android:topRightRadius="12dp"
        android:bottomLeftRadius="12dp"
        android:bottomRightRadius="12dp" />
    <padding
        android:left="10dp"
        android:top="8dp"
        android:right="10dp"
        android:bottom="8dp" />
</shape>
BUBBLE_IN_EOF

# ============================================================
# res/drawable/ic_send.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_send.xml" << 'IC_SEND_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FFFFFF"
        android:pathData="M2.01,21L23,12 2.01,3 2,10l15,2-15,2z" />
</vector>
IC_SEND_EOF

# ============================================================
# res/drawable/ic_call.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_call.xml" << 'IC_CALL_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FFFFFF"
        android:pathData="M6.6,10.8c1.4,2.8 3.8,5.1 6.6,6.6l2.2-2.2c0.3-0.3 0.7-0.4 1,-0.2 1.1,0.4 2.3,0.6 3.6,0.6 0.6,0 1,0.4 1,1V20c0,0.6-0.4,1-1,1-9.4,0-17-7.6-17-17 0-0.6 0.4-1 1-1h3.5c0.6,0 1,0.4 1,1 0,1.3 0.2,2.5 0.6,3.6 0.1,0.3 0,0.7-0.2,1L6.6,10.8z" />
</vector>
IC_CALL_EOF

# ============================================================
# res/drawable/ic_video_call.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_video_call.xml" << 'IC_VIDEO_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FFFFFF"
        android:pathData="M17,10.5V7c0-0.55-0.45-1-1-1H4c-0.55,0-1,0.45-1,1v10c0,0.55 0.45,1 1,1h12c0.55,0 1-0.45,1-1v-3.5l4,4v-11l-4,4z" />
</vector>
IC_VIDEO_EOF

# ============================================================
# res/drawable/ic_chat.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_chat.xml" << 'IC_CHAT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FF000000"
        android:pathData="M20,2H4c-1.1,0-2,0.9-2,2v18l4-4h14c1.1,0 2-0.9 2-2V4c0-1.1-0.9-2-2-2z" />
</vector>
IC_CHAT_EOF

# ============================================================
# res/drawable/ic_calls.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_calls.xml" << 'IC_CALLS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FF000000"
        android:pathData="M6.6,10.8c1.4,2.8 3.8,5.1 6.6,6.6l2.2-2.2c0.3-0.3 0.7-0.4 1,-0.2 1.1,0.4 2.3,0.6 3.6,0.6 0.6,0 1,0.4 1,1V20c0,0.6-0.4,1-1,1-9.4,0-17-7.6-17-17 0-0.6 0.4-1 1-1h3.5c0.6,0 1,0.4 1,1 0,1.3 0.2,2.5 0.6,3.6 0.1,0.3 0,0.7-0.2,1L6.6,10.8z" />
</vector>
IC_CALLS_EOF

# ============================================================
# res/drawable/ic_people.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_people.xml" << 'IC_PEOPLE_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FF000000"
        android:pathData="M16,11c1.66,0 2.99-1.34 2.99-3S17.66,5 16,5c-1.66,0-3,1.34-3,3s1.34,3 3,3zM8,11c1.66,0 2.99-1.34 2.99-3S9.66,5 8,5C6.34,5 5,6.34 5,8s1.34,3 3,3zM8,13c-2.33,0-7,1.17-7,3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zM16,13c-0.29,0-0.62,0.02-0.97,0.05 1.16,0.84 1.97,1.97 1.97,3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z" />
</vector>
IC_PEOPLE_EOF

# ============================================================
# res/drawable/ic_settings.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_settings.xml" << 'IC_SETTINGS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FF000000"
        android:pathData="M19.14,12.94c0.04-0.3 0.06-0.61 0.06-0.94 0-0.32-0.02-0.64-0.07-0.94l2.03-1.58c0.18-0.14 0.23-0.41 0.12-0.61l-1.92-3.32c-0.12-0.22-0.37-0.29-0.59-0.22l-2.39,0.96c-0.5-0.38-1.03-0.7-1.62-0.94L14.4,2.81c-0.04-0.24-0.24-0.41-0.48-0.41h-3.84c-0.24,0-0.43,0.17-0.47,0.41L9.25,5.35C8.66,5.59 8.12,5.92 7.63,6.29L5.24,5.33c-0.22-0.08-0.47,0-0.59,0.22L2.74,8.87C2.62,9.08 2.66,9.34 2.86,9.48l2.03,1.58C4.84,11.36 4.8,11.69 4.8,12s0.02,0.64 0.07,0.94l-2.03,1.58c-0.18,0.14-0.23,0.41-0.12,0.61l1.92,3.32c0.12,0.22 0.37,0.29 0.59,0.22l2.39-0.96c0.5,0.38 1.03,0.7 1.62,0.94l0.36,2.54c0.05,0.24 0.24,0.41 0.48,0.41h3.84c0.24,0 0.44-0.17 0.47-0.41l0.36-2.54c0.59-0.24 1.13-0.56 1.62-0.94l2.39,0.96c0.22,0.08 0.47,0 0.59-0.22l1.92-3.32c0.12-0.22 0.07-0.47-0.12-0.61L19.14,12.94zM12,15.6c-1.98,0-3.6-1.62-3.6-3.6s1.62-3.6 3.6-3.6 3.6,1.62 3.6,3.6S13.98,15.6 12,15.6z" />
</vector>
IC_SETTINGS_EOF

# ============================================================
# res/drawable/ic_developer.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_developer.xml" << 'IC_DEV_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#FF000000"
        android:pathData="M9.4,16.6L4.8,12l4.6-4.6L8,6l-6,6 6,6 1.4-1.4zM14.6,16.6l4.6-4.6-4.6-4.6L16,6l6,6-6,6-1.4-1.4z" />
</vector>
IC_DEV_EOF

# ============================================================
# res/drawable/bg_login.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/bg_login.xml" << 'BG_LOGIN_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <gradient
        android:angle="270"
        android:startColor="#075E54"
        android:endColor="#128C7E"
        android:type="linear" />
</shape>
BG_LOGIN_EOF

# ============================================================
# res/drawable/rounded_edittext.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/rounded_edittext.xml" << 'ROUNDED_ET_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <solid android:color="#FFFFFF" />
    <corners android:radius="25dp" />
    <stroke android:width="1dp" android:color="#E0E0E0" />
    <padding android:left="16dp" android:top="12dp" android:right="16dp" android:bottom="12dp" />
</shape>
ROUNDED_ET_EOF

# ============================================================
# res/drawable/btn_primary.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/btn_primary.xml" << 'BTN_PRIMARY_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <solid android:color="#25D366" />
    <corners android:radius="25dp" />
    <padding android:left="16dp" android:top="12dp" android:right="16dp" android:bottom="12dp" />
</shape>
BTN_PRIMARY_EOF

# ============================================================
# res/drawable/ic_mic.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/ic_mic.xml" << 'IC_MIC_EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#666666"
        android:pathData="M12,14c1.66,0 2.99-1.34 2.99-3L15,5c0-1.66-1.34-3-3-3S9,3.34 9,5v6c0,1.66 1.34,3 3,3zM17.3,11c0,3-2.54,5.1-5.3,5.1S6.7,14 6.7,11H5c0,3.41 2.72,6.23 6,6.72V21h2v-3.28c3.28-0.48 6-3.3 6-6.72h-1.7z" />
</vector>
IC_MIC_EOF

# ============================================================
# res/drawable/circle_button.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/circle_button.xml" << 'CIRCLE_BTN_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="oval">
    <solid android:color="#25D366" />
</shape>
CIRCLE_BTN_EOF

# ============================================================
# res/drawable/circle_red_button.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/drawable/circle_red_button.xml" << 'CIRCLE_RED_EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="oval">
    <solid android:color="#F44336" />
</shape>
CIRCLE_RED_EOF

# ============================================================
# res/menu/bottom_nav_menu.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/menu/bottom_nav_menu.xml" << 'MENU_EOF'
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item
        android:id="@+id/nav_chat"
        android:icon="@drawable/ic_chat"
        android:title="@string/tab_chat" />
    <item
        android:id="@+id/nav_calls"
        android:icon="@drawable/ic_calls"
        android:title="@string/tab_calls" />
    <item
        android:id="@+id/nav_friends"
        android:icon="@drawable/ic_people"
        android:title="@string/tab_friends" />
    <item
        android:id="@+id/nav_settings"
        android:icon="@drawable/ic_settings"
        android:title="@string/tab_settings" />
    <item
        android:id="@+id/nav_developer"
        android:icon="@drawable/ic_developer"
        android:title="@string/tab_developer" />
</menu>
MENU_EOF

# ============================================================
# layout/activity_login.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/activity_login.xml" << 'LOGIN_LAYOUT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/colorBackground"
    android:fillViewport="true">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:gravity="center">

        <!-- Header -->
        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:background="@drawable/bg_login"
            android:orientation="vertical"
            android:gravity="center"
            android:paddingTop="60dp"
            android:paddingBottom="40dp">

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="NexChat"
                android:textColor="#FFFFFF"
                android:textSize="36sp"
                android:textStyle="bold"
                android:fontFamily="sans-serif-medium" />

            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="Connect. Chat. Call."
                android:textColor="#B2DFDB"
                android:textSize="16sp"
                android:layout_marginTop="8dp" />
        </LinearLayout>

        <!-- Form -->
        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:padding="32dp">

            <EditText
                android:id="@+id/etEmail"
                android:layout_width="match_parent"
                android:layout_height="56dp"
                android:hint="@string/email_hint"
                android:inputType="textEmailAddress"
                android:background="@drawable/rounded_edittext"
                android:textSize="16sp"
                android:paddingLeft="20dp"
                android:paddingRight="20dp"
                android:imeOptions="actionNext" />

            <EditText
                android:id="@+id/etPassword"
                android:layout_width="match_parent"
                android:layout_height="56dp"
                android:hint="@string/password_hint"
                android:inputType="textPassword"
                android:background="@drawable/rounded_edittext"
                android:textSize="16sp"
                android:paddingLeft="20dp"
                android:paddingRight="20dp"
                android:layout_marginTop="16dp"
                android:imeOptions="actionDone" />

            <Button
                android:id="@+id/btnLogin"
                android:layout_width="match_parent"
                android:layout_height="56dp"
                android:text="Login"
                android:textColor="#FFFFFF"
                android:textSize="16sp"
                android:textStyle="bold"
                android:background="@drawable/btn_primary"
                android:layout_marginTop="24dp" />

            <Button
                android:id="@+id/btnSignUp"
                android:layout_width="match_parent"
                android:layout_height="56dp"
                android:text="Create Account"
                android:textColor="@color/colorPrimary"
                android:textSize="16sp"
                android:background="@android:color/transparent"
                android:layout_marginTop="8dp" />

            <View
                android:layout_width="match_parent"
                android:layout_height="1dp"
                android:background="@color/colorDivider"
                android:layout_marginTop="16dp"
                android:layout_marginBottom="16dp" />

            <com.google.android.material.button.MaterialButton
                android:id="@+id/btnGoogleSignIn"
                android:layout_width="match_parent"
                android:layout_height="56dp"
                android:text="Continue with Google"
                android:textColor="@color/colorTextPrimary"
                android:textSize="15sp"
                style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                android:strokeColor="@color/colorDivider" />

            <TextView
                android:id="@+id/tvError"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:textColor="#F44336"
                android:textSize="14sp"
                android:gravity="center"
                android:layout_marginTop="12dp"
                android:visibility="gone" />

        </LinearLayout>
    </LinearLayout>
</ScrollView>
LOGIN_LAYOUT_EOF

# ============================================================
# layout/activity_main.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/activity_main.xml" << 'MAIN_LAYOUT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/colorBackground">

    <com.google.android.material.appbar.MaterialToolbar
        android:id="@+id/toolbar"
        android:layout_width="0dp"
        android:layout_height="56dp"
        android:background="@color/colorPrimary"
        app:title="NexChat"
        app:titleTextColor="@color/colorWhite"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        android:elevation="4dp" />

    <FrameLayout
        android:id="@+id/fragmentContainer"
        android:layout_width="0dp"
        android:layout_height="0dp"
        app:layout_constraintTop_toBottomOf="@id/toolbar"
        app:layout_constraintBottom_toTopOf="@id/bottomNav"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <com.google.android.material.bottomnavigation.BottomNavigationView
        android:id="@+id/bottomNav"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:background="@color/colorWhite"
        app:menu="@menu/bottom_nav_menu"
        app:itemIconTint="@color/colorPrimary"
        app:itemTextColor="@color/colorPrimary"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        android:elevation="8dp" />

</androidx.constraintlayout.widget.ConstraintLayout>
MAIN_LAYOUT_EOF

# ============================================================
# layout/activity_chat.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/activity_chat.xml" << 'CHAT_ACT_LAYOUT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/colorBackground">

    <com.google.android.material.appbar.MaterialToolbar
        android:id="@+id/chatToolbar"
        android:layout_width="0dp"
        android:layout_height="56dp"
        android:background="@color/colorPrimary"
        app:titleTextColor="@color/colorWhite"
        app:subtitleTextColor="#B2DFDB"
        app:navigationIcon="@drawable/ic_calls"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/rvMessages"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:padding="8dp"
        android:clipToPadding="false"
        app:layout_constraintTop_toBottomOf="@id/chatToolbar"
        app:layout_constraintBottom_toTopOf="@id/llInputArea"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <LinearLayout
        android:id="@+id/llInputArea"
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:background="@color/colorWhite"
        android:padding="8dp"
        android:gravity="center_vertical"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent">

        <ImageButton
            android:id="@+id/btnMic"
            android:layout_width="40dp"
            android:layout_height="40dp"
            android:src="@drawable/ic_mic"
            android:background="@android:color/transparent"
            android:contentDescription="Voice message" />

        <EditText
            android:id="@+id/etMessage"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:hint="@string/type_message"
            android:background="@drawable/rounded_edittext"
            android:textSize="15sp"
            android:maxLines="4"
            android:paddingLeft="16dp"
            android:paddingRight="16dp"
            android:paddingTop="8dp"
            android:paddingBottom="8dp"
            android:layout_marginStart="8dp"
            android:layout_marginEnd="8dp"
            android:imeOptions="actionSend"
            android:inputType="textMultiLine|textCapSentences" />

        <ImageButton
            android:id="@+id/btnSend"
            android:layout_width="44dp"
            android:layout_height="44dp"
            android:src="@drawable/ic_send"
            android:background="@drawable/circle_button"
            android:padding="10dp"
            android:contentDescription="Send message" />

    </LinearLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
CHAT_ACT_LAYOUT_EOF

# ============================================================
# layout/activity_call.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/activity_call.xml" << 'CALL_ACT_LAYOUT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#1A1A2E">

    <!-- Remote video view -->
    <FrameLayout
        android:id="@+id/remoteVideoContainer"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:background="#0D0D1A"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintBottom_toTopOf="@id/llCallControls"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <!-- Local video view (PiP) -->
    <FrameLayout
        android:id="@+id/localVideoContainer"
        android:layout_width="120dp"
        android:layout_height="160dp"
        android:background="#2C2C54"
        android:layout_margin="16dp"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <!-- Caller name -->
    <TextView
        android:id="@+id/tvCallerName"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Calling..."
        android:textColor="#FFFFFF"
        android:textSize="24sp"
        android:textStyle="bold"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        android:layout_marginTop="80dp" />

    <TextView
        android:id="@+id/tvCallStatus"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Connecting..."
        android:textColor="#B2DFDB"
        android:textSize="16sp"
        app:layout_constraintTop_toBottomOf="@id/tvCallerName"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        android:layout_marginTop="8dp" />

    <!-- Call controls -->
    <LinearLayout
        android:id="@+id/llCallControls"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:gravity="center"
        android:paddingBottom="48dp"
        android:paddingTop="24dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent">

        <ImageButton
            android:id="@+id/btnMuteCall"
            android:layout_width="60dp"
            android:layout_height="60dp"
            android:src="@drawable/ic_mic"
            android:background="@drawable/circle_button"
            android:padding="14dp"
            android:layout_marginEnd="32dp"
            android:contentDescription="Mute" />

        <ImageButton
            android:id="@+id/btnEndCall"
            android:layout_width="70dp"
            android:layout_height="70dp"
            android:src="@drawable/ic_calls"
            android:background="@drawable/circle_red_button"
            android:padding="16dp"
            android:contentDescription="End call" />

        <ImageButton
            android:id="@+id/btnSwitchCamera"
            android:layout_width="60dp"
            android:layout_height="60dp"
            android:src="@drawable/ic_video_call"
            android:background="@drawable/circle_button"
            android:padding="14dp"
            android:layout_marginStart="32dp"
            android:contentDescription="Switch camera" />

    </LinearLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
CALL_ACT_LAYOUT_EOF

# ============================================================
# layout/fragment_chat_list.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/fragment_chat_list.xml" << 'FRAG_CHAT_LIST_EOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/colorBackground">

    <com.google.android.material.floatingactionbutton.FloatingActionButton
        android:id="@+id/fabNewChat"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:src="@drawable/ic_chat"
        app:backgroundTint="@color/colorAccent"
        app:tint="@color/colorWhite"
        android:layout_margin="16dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/rvChatList"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:background="@color/colorWhite"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
FRAG_CHAT_LIST_EOF

# ============================================================
# layout/fragment_calls.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/fragment_calls.xml" << 'FRAG_CALLS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/colorWhite">

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/rvCallLog"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</LinearLayout>
FRAG_CALLS_EOF

# ============================================================
# layout/fragment_friends.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/fragment_friends.xml" << 'FRAG_FRIENDS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/colorWhite">

    <com.google.android.material.textfield.TextInputLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="12dp"
        style="@style/Widget.MaterialComponents.TextInputLayout.OutlinedBox">

        <com.google.android.material.textfield.TextInputEditText
            android:id="@+id/etSearchFriend"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="Search by email..."
            android:inputType="textEmailAddress" />
    </com.google.android.material.textfield.TextInputLayout>

    <Button
        android:id="@+id/btnAddFriend"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Add Friend"
        android:backgroundTint="@color/colorPrimary"
        android:textColor="@color/colorWhite"
        android:layout_gravity="end"
        android:layout_marginEnd="12dp" />

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/rvFriends"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_marginTop="8dp" />

</LinearLayout>
FRAG_FRIENDS_EOF

# ============================================================
# layout/fragment_settings.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/fragment_settings.xml" << 'FRAG_SETTINGS_EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/colorBackground">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:padding="16dp">

        <!-- Profile Card -->
        <com.google.android.material.card.MaterialCardView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginBottom="16dp"
            app:cardCornerRadius="12dp"
            app:cardElevation="4dp"
            xmlns:app="http://schemas.android.com/apk/res-auto">

            <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="vertical"
                android:gravity="center"
                android:padding="24dp">

                <TextView
                    android:layout_width="80dp"
                    android:layout_height="80dp"
                    android:text="NC"
                    android:gravity="center"
                    android:textSize="28sp"
                    android:textStyle="bold"
                    android:textColor="@color/colorWhite"
                    android:background="@drawable/circle_button" />

                <TextView
                    android:id="@+id/tvUserName"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="User"
                    android:textSize="20sp"
                    android:textStyle="bold"
                    android:layout_marginTop="12dp"
                    android:textColor="@color/colorTextPrimary" />

                <TextView
                    android:id="@+id/tvUserEmail"
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:text="user@example.com"
                    android:textSize="14sp"
                    android:textColor="@color/colorTextSecondary"
                    android:layout_marginTop="4dp" />
            </LinearLayout>
        </com.google.android.material.card.MaterialCardView>

        <!-- Settings Options -->
        <com.google.android.material.card.MaterialCardView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            app:cardCornerRadius="12dp"
            app:cardElevation="2dp"
            xmlns:app="http://schemas.android.com/apk/res-auto">

            <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="vertical">

                <TextView
                    android:id="@+id/tvNotifications"
                    android:layout_width="match_parent"
                    android:layout_height="56dp"
                    android:text="Notifications"
                    android:textSize="16sp"
                    android:gravity="center_vertical"
                    android:paddingStart="20dp"
                    android:textColor="@color/colorTextPrimary" />

                <View android:layout_width="match_parent" android:layout_height="1dp" android:background="@color/colorDivider" />

                <TextView
                    android:id="@+id/tvPrivacy"
                    android:layout_width="match_parent"
                    android:layout_height="56dp"
                    android:text="Privacy"
                    android:textSize="16sp"
                    android:gravity="center_vertical"
                    android:paddingStart="20dp"
                    android:textColor="@color/colorTextPrimary" />

                <View android:layout_width="match_parent" android:layout_height="1dp" android:background="@color/colorDivider" />

                <TextView
                    android:id="@+id/tvTheme"
                    android:layout_width="match_parent"
                    android:layout_height="56dp"
                    android:text="Theme"
                    android:textSize="16sp"
                    android:gravity="center_vertical"
                    android:paddingStart="20dp"
                    android:textColor="@color/colorTextPrimary" />

                <View android:layout_width="match_parent" android:layout_height="1dp" android:background="@color/colorDivider" />

                <TextView
                    android:id="@+id/tvLogout"
                    android:layout_width="match_parent"
                    android:layout_height="56dp"
                    android:text="Logout"
                    android:textSize="16sp"
                    android:gravity="center_vertical"
                    android:paddingStart="20dp"
                    android:textColor="#F44336" />

            </LinearLayout>
        </com.google.android.material.card.MaterialCardView>

    </LinearLayout>
</ScrollView>
FRAG_SETTINGS_EOF

# ============================================================
# layout/fragment_developer.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/fragment_developer.xml" << 'FRAG_DEV_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:background="@drawable/bg_login"
    android:padding="32dp">

    <TextView
        android:layout_width="100dp"
        android:layout_height="100dp"
        android:text="NC"
        android:gravity="center"
        android:textSize="36sp"
        android:textStyle="bold"
        android:textColor="@color/colorPrimary"
        android:background="@color/colorWhite"
        android:layout_marginBottom="32dp" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="NexChat"
        android:textColor="#FFFFFF"
        android:textSize="40sp"
        android:textStyle="bold"
        android:fontFamily="sans-serif-medium" />

    <View
        android:layout_width="60dp"
        android:layout_height="3dp"
        android:background="#25D366"
        android:layout_marginTop="12dp"
        android:layout_marginBottom="24dp" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Developed by Ankan"
        android:textColor="#B2DFDB"
        android:textSize="20sp"
        android:textStyle="bold" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Ankan Corporation"
        android:textColor="#80CBC4"
        android:textSize="14sp"
        android:layout_marginTop="4dp" />

    <View
        android:layout_width="40dp"
        android:layout_height="1dp"
        android:background="#4DB6AC"
        android:layout_marginTop="24dp"
        android:layout_marginBottom="24dp" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Custom Messenger App with\nChat &amp; Calling"
        android:textColor="#E0F2F1"
        android:textSize="16sp"
        android:gravity="center"
        android:lineSpacingExtra="4dp" />

    <LinearLayout
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="horizontal"
        android:layout_marginTop="40dp">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Version 1.0"
            android:textColor="#80CBC4"
            android:textSize="13sp"
            android:layout_marginEnd="16dp" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="\u00a92025 Ankan"
            android:textColor="#80CBC4"
            android:textSize="13sp" />

    </LinearLayout>

</LinearLayout>
FRAG_DEV_EOF

# ============================================================
# layout/item_message_outgoing.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/item_message_outgoing.xml" << 'ITEM_MSG_OUT_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="end"
    android:paddingStart="64dp"
    android:paddingEnd="8dp"
    android:paddingTop="4dp"
    android:paddingBottom="4dp">

    <LinearLayout
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:background="@drawable/bubble_outgoing"
        android:maxWidth="280dp">

        <TextView
            android:id="@+id/tvMessage"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="15sp"
            android:textColor="@color/colorTextPrimary"
            android:maxWidth="260dp" />

        <TextView
            android:id="@+id/tvTimestamp"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="11sp"
            android:textColor="@color/colorTextSecondary"
            android:layout_gravity="end"
            android:layout_marginTop="2dp" />
    </LinearLayout>

</LinearLayout>
ITEM_MSG_OUT_EOF

# ============================================================
# layout/item_message_incoming.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/item_message_incoming.xml" << 'ITEM_MSG_IN_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:gravity="start"
    android:paddingStart="8dp"
    android:paddingEnd="64dp"
    android:paddingTop="4dp"
    android:paddingBottom="4dp">

    <LinearLayout
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:background="@drawable/bubble_incoming"
        android:maxWidth="280dp">

        <TextView
            android:id="@+id/tvSenderName"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="12sp"
            android:textColor="@color/colorPrimary"
            android:textStyle="bold"
            android:visibility="gone" />

        <TextView
            android:id="@+id/tvMessage"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="15sp"
            android:textColor="@color/colorTextPrimary"
            android:maxWidth="260dp" />

        <TextView
            android:id="@+id/tvTimestamp"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:textSize="11sp"
            android:textColor="@color/colorTextSecondary"
            android:layout_gravity="end"
            android:layout_marginTop="2dp" />
    </LinearLayout>

</LinearLayout>
ITEM_MSG_IN_EOF

# ============================================================
# layout/item_chat_user.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/item_chat_user.xml" << 'ITEM_CHAT_USER_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:padding="12dp"
    android:gravity="center_vertical"
    android:background="?attr/selectableItemBackground">

    <TextView
        android:id="@+id/tvAvatar"
        android:layout_width="50dp"
        android:layout_height="50dp"
        android:gravity="center"
        android:textSize="20sp"
        android:textStyle="bold"
        android:textColor="@color/colorWhite"
        android:background="@drawable/circle_button"
        android:text="U" />

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical"
        android:layout_marginStart="12dp">

        <TextView
            android:id="@+id/tvUserName"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="User Name"
            android:textSize="16sp"
            android:textStyle="bold"
            android:textColor="@color/colorTextPrimary" />

        <TextView
            android:id="@+id/tvLastMessage"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Last message..."
            android:textSize="14sp"
            android:textColor="@color/colorTextSecondary"
            android:maxLines="1"
            android:ellipsize="end"
            android:layout_marginTop="2dp" />

    </LinearLayout>

    <TextView
        android:id="@+id/tvTime"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="12:00"
        android:textSize="12sp"
        android:textColor="@color/colorTextSecondary" />

</LinearLayout>
ITEM_CHAT_USER_EOF

# ============================================================
# layout/item_call_log.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/item_call_log.xml" << 'ITEM_CALL_LOG_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:padding="12dp"
    android:gravity="center_vertical"
    android:background="?attr/selectableItemBackground">

    <TextView
        android:id="@+id/tvCallAvatar"
        android:layout_width="50dp"
        android:layout_height="50dp"
        android:gravity="center"
        android:textSize="20sp"
        android:textStyle="bold"
        android:textColor="@color/colorWhite"
        android:background="@drawable/circle_button"
        android:text="U" />

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical"
        android:layout_marginStart="12dp">

        <TextView
            android:id="@+id/tvCallUserName"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="User Name"
            android:textSize="16sp"
            android:textStyle="bold"
            android:textColor="@color/colorTextPrimary" />

        <TextView
            android:id="@+id/tvCallType"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Incoming call"
            android:textSize="13sp"
            android:textColor="@color/colorTextSecondary"
            android:layout_marginTop="2dp" />
    </LinearLayout>

    <ImageButton
        android:id="@+id/btnCallBack"
        android:layout_width="40dp"
        android:layout_height="40dp"
        android:src="@drawable/ic_call"
        android:background="@android:color/transparent"
        android:tint="@color/colorPrimary"
        android:contentDescription="Call back" />

</LinearLayout>
ITEM_CALL_LOG_EOF

# ============================================================
# layout/item_friend.xml
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/res/layout/item_friend.xml" << 'ITEM_FRIEND_EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal"
    android:padding="12dp"
    android:gravity="center_vertical"
    android:background="?attr/selectableItemBackground">

    <TextView
        android:id="@+id/tvFriendAvatar"
        android:layout_width="50dp"
        android:layout_height="50dp"
        android:gravity="center"
        android:textSize="20sp"
        android:textStyle="bold"
        android:textColor="@color/colorWhite"
        android:background="@drawable/circle_button"
        android:text="F" />

    <LinearLayout
        android:layout_width="0dp"
        android:layout_height="wrap_content"
        android:layout_weight="1"
        android:orientation="vertical"
        android:layout_marginStart="12dp">

        <TextView
            android:id="@+id/tvFriendName"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Friend Name"
            android:textSize="16sp"
            android:textStyle="bold"
            android:textColor="@color/colorTextPrimary" />

        <TextView
            android:id="@+id/tvFriendEmail"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="friend@email.com"
            android:textSize="13sp"
            android:textColor="@color/colorTextSecondary"
            android:layout_marginTop="2dp" />
    </LinearLayout>

    <ImageButton
        android:id="@+id/btnChatFriend"
        android:layout_width="40dp"
        android:layout_height="40dp"
        android:src="@drawable/ic_chat"
        android:background="@android:color/transparent"
        android:tint="@color/colorPrimary"
        android:contentDescription="Chat" />

</LinearLayout>
ITEM_FRIEND_EOF

# ============================================================
# MODEL: Message.java
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/models/Message.java" << 'MESSAGE_MODEL_EOF'
package com.example.nexchat.models;

public class Message {
    private String messageId;
    private String senderId;
    private String receiverId;
    private String text;
    private long timestamp;
    private boolean isRead;
    private String type; // "text", "image", "voice"

    public Message() {}

    public Message(String messageId, String senderId, String receiverId, String text, long timestamp) {
        this.messageId = messageId;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.text = text;
        this.timestamp = timestamp;
        this.isRead = false;
        this.type = "text";
    }

    public String getMessageId() { return messageId; }
    public void setMessageId(String messageId) { this.messageId = messageId; }

    public String getSenderId() { return senderId; }
    public void setSenderId(String senderId) { this.senderId = senderId; }

    public String getReceiverId() { return receiverId; }
    public void setReceiverId(String receiverId) { this.receiverId = receiverId; }

    public String getText() { return text; }
    public void setText(String text) { this.text = text; }

    public long getTimestamp() { return timestamp; }
    public void setTimestamp(long timestamp) { this.timestamp = timestamp; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
}
MESSAGE_MODEL_EOF

# ============================================================
# MODEL: User.java
# ============================================================
cat > "$PROJECT_ROOT/app/src/main/java/$PACKAGE_PATH/models/User.java" << 'USER_MODEL_EOF'
package com.example.nexchat.models;

public class User {
    private String uid;
    private String name;
    private String email;
    private String photoUrl;
    private String status;
    private long lastSeen;
    private boolean isOnline;
    private String fcmToken;

    public User() {}

    public User(String uid, String name, String email) {
        this.uid = uid;
        
        this.name = name;
        this.email = email;
        this.status = "Hey there! I am using NexChat.";
        this.isOnline = true;
        this.lastSeen = System.currentTimeMillis();
    }

    public String getUid() { return uid; }
    public void setUid(String uid) { this.uid = uid; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public long getLastSeen() { return lastSeen; 
