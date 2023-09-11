# Youtube firebase setup
https://www.youtube.com/watch?v=2yV1RaO74qE&list=PLjPfp4Ph3gBq4PcGF3YmqBAnTIETrgpHv
- make sure, look ep1 first for setup firebase core

1. Create firebase project
2. Download google-services.json and paste into android/app
3. Setup build.gradle apply plugin: 'com.google.gms.google-services'
3.1.   firebase_analytics: ^10.4.4
       firebase_core: ^2.15.0

3.2 For iOS
  Download GoogleService-Info.plist and paste in iOS/Runner folder

3.2. For Android
For Android
# minSdkVersion 21

# /android/app/build.gradle
implementation platform('com.google.firebase:firebase-bom:31.0.1')
implementation 'com.google.firebase:firebase-analytics-ktx'

# /android/app/build.gradle
apply plugin: 'com.google.gms.google-services'

# /android/build.gradle
classpath 'com.google.gms:google-services:4.3.13'

3.3. Enable Faster debug firebase analytic: adb shell setprop debug.firebase.analytics.app com.codemobiles.flutter.demo1
4. Configure Anaylytics as follow:

5. To view realtime analytic
   - Go to Firebase analytic and click debugView