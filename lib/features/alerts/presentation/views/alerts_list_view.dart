import 'package:flutter/material.dart';

import '../widgets/seismic_alerts_tab.dart';
import '../widgets/weather_alerts_tab.dart';

class AlertsListView extends StatelessWidget {
  const AlertsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alertas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sismos'),
              Tab(text: 'Clima'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [SeismicAlertsTab(), WeatherAlertsTab()],
        ),
      ),
    );
  }
}
