import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  MapSample({Key? key,required this.addressLat,required this.addressLong}) : super(key: key);
  double? addressLat;
  double? addressLong;
  @override
  State<MapSample> createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition;

  Completer<GoogleMapController> controller1 = Completer();


  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    super.initState();
    // addressLat = double.parse(21.1458.toString());
    // addressLong = double.parse(79.0882.toString());
    _lastMapPosition = LatLng(widget.addressLat!, widget.addressLong!);

    _markers.add(Marker(
        markerId: MarkerId(151.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: "You are here",
            snippet: "This is a current location snippet",
            onTap: () {}),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: const Text('Google Map'),
        backgroundColor: Colors.white,
      ),
      body:  Container(

          //  height: MediaQuery.of(context).size.height * 0.21,
          // width: MediaQuery.of(context).size.width * 0.99,
          decoration: BoxDecoration(
              color: Color(0Xfffdf1f5),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width * 0.99,
                  child: GoogleMap(
                    markers: _markers,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: false,
                    scrollGesturesEnabled: true,
                    mapType: _currentMapType,
                    initialCameraPosition: CameraPosition(
                      target: _lastMapPosition,
                      zoom: 16.4746,
                    ),
                    onMapCreated: _onMapCreated,
                    onCameraMove: _onCameraMove,
                    myLocationEnabled: false,
                    compassEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}