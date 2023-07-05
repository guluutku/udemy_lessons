import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:udemy_lessons/models/location_model.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({
    super.key,
    required this.onSelectLocation,
  });
  final void Function(LocationModel locationModel) onSelectLocation;

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  LocationData? locationData;
  bool isGettingLocation = false;
  LocationModel? _locationModel;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();

    if (locationData!.latitude == null || locationData!.longitude == null) {
      return;
    }

    setState(() {
      _locationModel = LocationModel(
        latitude: locationData!.latitude!,
        longitude: locationData!.longitude!,
      );
      isGettingLocation = false;
    });

    widget.onSelectLocation(_locationModel!);

    print('Location:  ${locationData!.latitude} , ${locationData!.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: isGettingLocation
              ? const CircularProgressIndicator()
              : Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
