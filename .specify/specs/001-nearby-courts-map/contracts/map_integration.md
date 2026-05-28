# Map Integration Contracts

## Location Permissions Flow

The `CourtsMapSection` acts as an active contract listener for the device ecosystem:
1. Initialize map configuration.
2. Intercept app usage for `LocationPermission`.
3. Check `Geolocator.isLocationServiceEnabled()`.
4. Validate `LocationPermission.denied` or `LocationPermission.deniedForever`.
5. Dispatch to default (Cairo) OR `Position` resolved coordinates.

## Permissions Configurations

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <application>
        ...
```

### iOS (`ios/Runner/Info.plist` - Note: For iOS execution later)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open to show nearby courts.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>
```
