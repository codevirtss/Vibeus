# Vibeus
Vibeus is a free dating app developed to connect our users all around the world without any subscription.
The main motive of vibeus is to help users finding their perfect match without any subscription.


## Plugins used for connecting our users on Vibeus.
```Pluguns Used in Vibeus
  
  #For iOS
  cupertino_icons: ^1.0.0
  ## Firebase Storage
  firebase_storage: ^3.1.5
  
  #Firebase Core
  firebase_core: ^0.4.4+3
  
  # Firebase Auth
  firebase_auth: ^0.16.0
  
  # Cloud FireStore
  cloud_firestore: ^0.13.5
  
  #Flutter bloc method is used in Vbeus
  flutter_bloc: ^3.2.0
  
  #Meta package
  meta: ^1.1.8
  
  #Equatable packages
  equatable: ^1.1.1
  
  #rcdart package
  rxdart: ^0.23.0
  
  #File picker used to pick file type image in profile setup screen
  file_picker: ^1.9.0
  
  #Font awwesome flutter package
  font_awesome_flutter: ^8.8.1
  
  #eva icons flutter
  eva_icons_flutter: ^2.0.0
  
  #ectende image
  extended_image: ^1.5.0
  
  #time ago package
  timeago: 
  
  # UUID id used in image upload page to generate unique posId on our database
  uuid: ^2.0.4
  
  #image picker is used to pick images from gallery and camera
  image_picker: ^0.6.7+17
  
  #transparent image is used in discover screen
  transparent_image: ^1.0.0
  
  #flytter date time picker is used in profile setup screen
  flutter_datetime_picker: ^1.4.0
  
  #Material design icon
  material_design_icons_flutter:
  
  #Likify is used in bio and chats
  flutter_linkify: ^4.0.2
  
  #this also used in bio and chat
  url_launcher: ^5.7.10
  
  #onesignal is used for showing notifications
  onesignal_flutter: ^2.6.2
  
  #Not used yet
  advance_pdf_viewer: ^1.2.1+2
  
  #For geting location 
  geolocator: ^5.3.1
  
  #not yet used
  google_maps_flutter: ^1.1.1
  
  #Bottoom navgation bar
  google_nav_bar: ^3.0.0
  line_icons: ^0.2.0
  
  # Emojies
  emoji_picker: ^0.1.0
  carousel_slider: ^1.3.0
```
## OneSignal in vibeus
```
buildscript {
    repositories {
        // ...
        maven { url 'https://plugins.gradle.org/m2/' } // Gradle Plugin Portal
    }
    dependencies {
        // ...
        // OneSignal-Gradle-Plugin
        classpath 'gradle.plugin.com.onesignal:onesignal-gradle-plugin:[0.12.6, 0.99.99]'
    }
}

apply plugin: 'com.onesignal.androidsdk.onesignal-gradle-plugin'
```

## Using Bloc method to authenticaticate Users
```
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final uid = await _userRepository.getUser();
        final isFirstTime = await _userRepository.isFirstTime(uid);

        if (!isFirstTime) {
          yield AuthenticatedButNotSet(uid);
        } else {
          yield Authenticated(uid);
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final isFirstTime =
        await _userRepository.isFirstTime(await _userRepository.getUser());

    if (!isFirstTime) {
      yield AuthenticatedButNotSet(await _userRepository.getUser());
    } else {
      yield Authenticated(await _userRepository.getUser());
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
```

## License
```
MIT License

Copyright (c) 2021 Vibeus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
## Get it on play store.
<a href="https://play.google.com/store/apps/details?id=com.vc.vibeus&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1">
<img alt="Get it on Google Play" src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" />	</a>

## *[Vibeus Privacy Policy](https://github.com/vibeus-con/vibeusprivacy/blob/main/Privacy.md)

## *[Vibeus Community Guildelines](https://github.com/vibeus-con/vibeus-con/blob/main/CommunityGuidelines.md)

## *[Vibeus Safety tips](https://github.com/vibeus-con/vibeus-con/blob/main/SafetyTips.md)

## Getting Started


A few resources to get you started if this is your first Flutter project:

- [Flutter](https://flutter.dev).
- [FlutterFire](https://firebase.flutter.dev/)

For help getting started with Flutter, view flutter ducmention
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

