import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FirstTab extends StatelessWidget {
  final panelController = PanelController();
  final double tabBarHeight = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SlidingUpPanel(
        controller: panelController,
        maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
        panelBuilder: (scrollController) => buildSlidingPanel(
            scrollController: scrollController,
            panelController: panelController,
            onClicked: panelController.open),
        body: Center(
            child: InteractiveViewer(
                child: Image.network(
                    'https://lh3.googleusercontent.com/proxy/9pMJnskr6PBB9DzQa8u9wHE_fuFbvYTwqamtA-MkzcgEFSTUuT_Sr0Ld5_SWcq00JGBRyUVrK6McDCCVyEb1Bbvq'))),
      ),
    ));
  }

  Widget buildSlidingPanel(
      {@required PanelController panelController,
      @required ScrollController scrollController,
      @required VoidCallback onClicked}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 150.0,
              height: 80.0,
              child: TextFormField(
                onTap: onClicked,
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 80.0,
              child: TextFormField(
                onTap: onClicked,
              ),
            )
          ],
        ),
        const Text("Заглушка #2"),
      ],
    );
  }
}
