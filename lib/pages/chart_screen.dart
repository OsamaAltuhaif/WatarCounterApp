import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '/models/water_provider.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final waterProvider = Provider.of<WaterProvider>(context);
    final chartData = waterProvider.getChartData();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: charts.BarChart(
              chartData,
              animate: true,
              animationDuration: Duration(milliseconds: 500),
              customSeriesRenderers: [
                charts.LineRendererConfig<String>(
                  customRendererId: 'customLine',
                  includePoints: true,
                ),
              ],
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: 12,
                    color: charts.MaterialPalette.black,
                  ),
                ),
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: 12,
                    color: charts.MaterialPalette.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'كمية الماء المستهلكة لكل يوم مقارنة بالهدف',
            style: TextStyle(fontSize: 16, color: Colors.blue, shadows: [
              BoxShadow(
                  color: Colors.deepPurple, blurRadius: 1, offset: Offset(1, 1))
            ]),
          ),
        ],
      ),
    );
  }
}
