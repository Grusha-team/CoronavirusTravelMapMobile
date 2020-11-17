import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:corona_travel/data/corona_travel_api.dart';

class FirstTab extends StatelessWidget {
  final panelController = PanelController();
  final double tabBarHeight = 80;
  final firstCountryController = TextEditingController();
  final secondCountryController = TextEditingController();

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
          body: Center(
              child: InteractiveViewer(
                  child: Image.network(
                      'https://i.pinimg.com/originals/4a/f7/4b/4af74b3c8bcc75c2ef8a7f338e8badbb.png'))),
        ),
      ),
    ));
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
          //TODO remove logic from UI, right now only for testing purpose
          var response = await CoronaTravelApi().getRoute(
              firstCountryController.text, secondCountryController.text);

          print(response);
        }),
      ],
    );
  }
}
