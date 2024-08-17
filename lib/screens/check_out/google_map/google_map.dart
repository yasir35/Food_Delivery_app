import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  LatLng _initialCameraPosition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();
  bool _isLocationListenerActive = false;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;

    if (!_isLocationListenerActive) {
      _location.onLocationChanged.listen((event) {
        _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(event.latitude!, event.longitude!), zoom: 15),
          ),
        );
      });
      _isLocationListenerActive = true;
    }
  }

  Future<void> _getLocationAndSet() async {
    final permissionGranted = await _location.requestPermission();
    if (permissionGranted == PermissionStatus.granted) {
      final locationData = await _location.getLocation();
      setState(() {
        context.read<CheckoutProvider>().setLoaction = locationData;
      });
      Navigator.of(context).pop();
    } else {
      // Handle permission not granted scenario
      print("Location permission denied.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialCameraPosition,
              ),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                child: MaterialButton(
                  onPressed: _getLocationAndSet,
                  color: primaryColor,
                  child: Text("Set Location"),
                  shape: StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
