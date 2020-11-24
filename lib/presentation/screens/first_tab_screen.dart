import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:corona_travel/data/corona_travel_api.dart';

class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  final panelController = PanelController();
  final double tabBarHeight = 80;
  final firstCountryController = TextEditingController();
  final secondCountryController = TextEditingController();
  Map stats;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          panelController.close();
          return;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SlidingUpPanel(
            controller: panelController,
            maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
            panelBuilder: (scrollController) => buildSlidingPanel(
              scrollController: scrollController,
              panelController: panelController,
            ),
            body: const Center(
              child: Text(''),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSlidingPanel({
    @required PanelController panelController,
    @required ScrollController scrollController,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 150.0,
              height: 80.0,
              child: TextFormField(
                controller: firstCountryController,
                onTap: panelController.open,
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 80.0,
              child: TextFormField(
                controller: secondCountryController,
                onTap: panelController.open,
              ),
            )
          ],
        ),
        RaisedButton(onPressed: () async {
          
        }),
      ],
    );
  }
}
