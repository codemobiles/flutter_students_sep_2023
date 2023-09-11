# Youtube firebase setup
https://www.youtube.com/watch?v=2yV1RaO74qE&list=PLjPfp4Ph3gBq4PcGF3YmqBAnTIETrgpHv
- make sure, look ep1 first for setup firebase core

1. Create firebase project
2. Download google-services.json and paste into android/app
3. Setup build.gradle apply plugin: 'com.google.gms.google-services'
3.1.   firebase_auth: ^4.7.1
       firebase_core: ^2.15.0

3.2 For iOS
  Download GoogleService-Info.plist and paste in iOS/Runner folder

3.2. For Android

# minSdkVersion 21

# /android/app/build.gradle
implementation platform('com.google.firebase:firebase-bom:31.0.1')
implementation 'com.google.firebase:firebase-analytics-ktx'

# /android/app/build.gradle

# /android/build.gradle
classpath 'com.google.gms:google-services:4.3.13'


4. Configure Authentication as follow:
 - Click Authentication Menu
 - Click Setup sign-in method
 - Click Username and password
 - Enable username-password option

- Check State of Login : FirebaseAuth.instance.authStateChanges()
   child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                }

- Register
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

- Login
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

- Forgot/Reset password
  await FirebaseAuth.instance.sendPasswordResetEmail(email: text);