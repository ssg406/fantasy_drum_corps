# Fantasy Drum Corps

Fantasy sports inspired Drum Corps game. Available live at [fantasydrumcorps.com](https://fantasydrumcorps.com).

## About

Fans of Drum Corps International can create tours of up to 22 people, draft their favorite drum corps captions in live draft events, and see their fantasy corps on a leaderboard as the season progresses. Authentication is managed through Firebase Auth, data is stored in Firebase Firestore, and the live draft is run on a Socket.io server which can be found at this [repository](https://github.com/ssg406/fantasy_drum_corps_server).

## Running the Client

1. Create a Firebase project to use when initializing the client.
2. Clone the repository and run `flutter pub get` to get dependencies.
3. In the root directory of the repository, run `firebase init` to create a firebase_options.dart and setup local emulators and hosting if you wish.
4. `flutter run -d chrome` to run the development server and start the application locally.
5. `firebase deploy` to deploy the client to Firebase hosting.
