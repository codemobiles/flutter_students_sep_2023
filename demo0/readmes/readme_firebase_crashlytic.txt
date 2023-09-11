# Youtube firebase setup
https://www.youtube.com/watch?v=2yV1RaO74qE&list=PLjPfp4Ph3gBq4PcGF3YmqBAnTIETrgpHv
- make sure, look ep1 first for setup firebase core

1. Create firebase project
2. Download google-services.json and paste into android/app
3. Setup build.gradle apply plugin: 'com.google.gms.google-services'
3.1.   cloud_firestore: ^4.8.3
       firebase_crashlytics: ^3.3.4

# Update build.gradle in app level
dependencies {
    // Import the BoM for the Firebase platform
    implementation(platform("com.google.firebase:firebase-bom:32.2.2"))

    // Add the dependencies for the Crashlytics and Analytics libraries
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation("com.google.firebase:firebase-crashlytics-ktx")
    implementation("com.google.firebase:firebase-analytics-ktx")
}

# Update build.gradle in root level
dependencies {
        classpath 'com.google.gms:google-services:4.3.13'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.8'
}

# Update Plugin in build.gradle in app level
apply plugin: 'com.google.firebase.crashlytics'

# Enable Crashlytic in widget page
- Call this in initState : await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
- Simulate crash with FirebaseCrashlytics.instance.crash();
- Make sure running in release mode
- Make sure re-open app that was crashed previously in order to send crash log.


3.2 For iOS
  Download GoogleService-Info.plist and paste in iOS/Runner folder

3.2. For Android

# minSdkVersion 21

# /android/app/build.gradle
implementation platform('com.google.firebase:firebase-bom:31.0.1')

