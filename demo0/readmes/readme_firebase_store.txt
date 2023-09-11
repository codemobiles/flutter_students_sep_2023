# Youtube firebase setup
https://www.youtube.com/watch?v=2yV1RaO74qE&list=PLjPfp4Ph3gBq4PcGF3YmqBAnTIETrgpHv
- make sure, look ep1 first for setup firebase core

1. Create firebase project
2. Download google-services.json and paste into android/app
3. Setup build.gradle apply plugin: 'com.google.gms.google-services'
3.1.   cloud_firestore: ^4.8.3
       firebase_core: ^2.15.0

3.2 For iOS
  Download GoogleService-Info.plist and paste in iOS/Runner folder

3.2. For Android

# minSdkVersion 21

# /android/app/build.gradle
implementation platform('com.google.firebase:firebase-bom:31.0.1')
implementation 'com.google.firebase:firebase-analytics-ktx'

# /android/app/build.gradle
apply plugin: 'com.google.gms.google-services'

# /android/build.gradle
classpath 'com.google.gms:google-services:4.3.13'       

4. add cloud_firestore: ^4.8.3 in pubspec.yaml
5. add this code in main.dart
   // setup firebase
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();


5. Configure Firebase Cloud FireStore as follow:
 - To access collection: userCollection = FirebaseFirestore.instance.collection('users');
 - Query all :
   return userCollection.orderBy("created", descending: true).snapshots().map((snapshot) {
       return snapshot.docs.map((doc) {
         final data = doc.data();
         final user = User.fromJson(data);
         return user;
       }).toList();
     });

 - Query where:
   final snapshot = await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: currentName).get();
     if (snapshot.docs.isNotEmpty) {
       CustomFlushbar.showError(context, message: "This name is already existed");
       return;
     }

- Create:
    final docUser = userCollection.doc();
    final user = User(
      id: docUser.id,
      name: nameTextFieldController.text,
      age: int.parse(ageTextFieldController.text),
      birthday: selectedDateTime,
      created: DateTime.now(),
    );

    await docUser.set(user.toJson());

- Delete:
  userCollection.doc(user.id).delete();

- Update:
  final user = User(
      id: selectedUserId,
      name: nameTextFieldController.text,
      age: int.parse(ageTextFieldController.text),
      birthday: selectedDateTime,
      created: DateTime.now(),
    );
    docRef.update(user.toJson());