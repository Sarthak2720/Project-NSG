import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: BroadcastLocationPage(),
  ));
}

class BroadcastLocationPage extends StatefulWidget {
  @override
  _BroadcastLocationPageState createState() => _BroadcastLocationPageState();
}

class _BroadcastLocationPageState extends State<BroadcastLocationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  List<BluetoothDevice> storedDevicesList = [];
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _requestPermissions();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _sizeAnimation = Tween<double>(begin: 20.0, end: 100.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (status.values.any((element) => element != PermissionStatus.granted)) {
      print('Bluetooth or Location permissions are not granted');
    } else {
      _startDiscovery();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    FlutterBluetoothSerial.instance.cancelDiscovery();
    super.dispose();
  }

  void _startDiscovery() async {
    setState(() {
      _isDiscovering = true;
    });

    BluetoothState state = await FlutterBluetoothSerial.instance.state;
    if (state != BluetoothState.STATE_ON) {
      print('Bluetooth is not enabled.');
      return;
    }

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      print('Discovered device: ${r.device.name}, Address: ${r.device.address}');

      setState(() {
        if (!storedDevicesList.any((device) => device.address == r.device.address)) {
          storedDevicesList.add(r.device);
        }

        // Update the correct location in Firebase based on the device name
        if (r.device.name == 'Sarthak') {
          _updateLocationInFirebase('Sarthak', 'Seminar Hall 1');
        } else if (r.device.name == 'Gomtesh') {
          _updateLocationInFirebase('Gomtesh', 'Lab B');
        } else if (r.device.name == 'DhwaniJain') {
          _updateLocationInFirebase('DhwaniJain', 'Lab A');
        }else if (r.device.name == 'Airdopes 138') {
          _updateLocationInFirebase('Airdopes 138', 'Seminar Hall 1');
        }
      });
    }).onDone(() {
      setState(() {
        _isDiscovering = false;
      });
      print('Discovery finished');
    });
  }

  Future<void> _updateLocationInFirebase(String name, String location) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("location");

      final snapshot = await ref.get();
      if (snapshot.exists) {
        final List<dynamic> locationList = snapshot.value as List<dynamic>;

        for (int i = 0; i < locationList.length; i++) {
          final item = locationList[i] as Map<dynamic, dynamic>;
          if (item['name'] == name) {
            // Update the value for the specific item in the list
            await ref.child('$i').update({'value': location});
            print('Location value updated for $name to: $location in Firebase');
            break;
          }
        }
      } else {
        print('Location list does not exist.');
      }
    } catch (e, stackTrace) {
      print('Failed to update location in Firebase: $e');
      print(stackTrace);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/nsglogo.png',
                  height: 100,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'National Security Guard',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ministry of Home Affairs,',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Govt of India',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Sarvatra Sarvottam Suraksha',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your location is being broadcasted',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: _sizeAnimation.value,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
