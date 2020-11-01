import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Map();
  }
}

class Model {
  const Model(this.continent, this.code, this.color);

  final String continent;
  final String code;
  final Color color;
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  List<Model> data;

  @override
  void initState() {
    super.initState();
    data = const <Model>[
      Model('Asia', 'Asia', Color.fromRGBO(60, 120, 255, 0.8)),
      Model('Africa', 'Africa', Color.fromRGBO(51, 102, 255, 0.8)),
      Model('Europe', 'Europe', Color.fromRGBO(0, 57, 230, 0.8)),
      Model('South America', 'SA', Color.fromRGBO(0, 51, 204, 0.8)),
      Model('Australia', 'Australia', Color.fromRGBO(0, 45, 179, 0.8)),
      Model('North America', 'NA', Color.fromRGBO(0, 38, 153, 0.8))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SfMaps(
              layers: [
                MapShapeLayer(
                  zoomPanBehavior: MapZoomPanBehavior(
                    zoomLevel: 5.0,
                  ),
                  delegate: MapShapeLayerDelegate(
                    shapeFile: "assets/custom.geo.json",
                    shapeDataField: "continent",
                    dataCount: data.length,
                    primaryValueMapper: (int index) => data[index].continent,
                    shapeColorValueMapper: (int index) => data[index].color,
                  ),
                  enableSelection: true,
                  onSelectionChanged: (int index) {
                    print('The selected region is ${data[index].code}');
                  },
                  initialSelectedIndex: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
