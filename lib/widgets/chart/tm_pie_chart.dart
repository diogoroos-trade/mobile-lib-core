import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configuration/tm_colors.dart';

class TmPieChart extends StatelessWidget {
  static final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();
  static final GlobalKey<AnimatedCircularChartState> chartKey2 = GlobalKey<AnimatedCircularChartState>();
  static final GlobalKey<AnimatedCircularChartState> chartKey3 = GlobalKey<AnimatedCircularChartState>();

  final double availableLimit;
  final double usedLimit;
  final double processedPurchase;
  final double purchaseToProcess;

  const TmPieChart({
    Key? key,
    required this.availableLimit,
    required this.usedLimit,
    required this.processedPurchase,
    required this.purchaseToProcess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Container(
            alignment: Alignment.center,
            child: AnimatedCircularChart(
              key: _chartKey,
              holeRadius: 100,
              size: const Size(255, 100),
              initialChartData: const <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(
                      100,
                      TmColors.iceGrey,
                      rankKey: 'completed',
                    ),
                  ],
                ),
              ],
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Container(
            alignment: Alignment.center,
            child: AnimatedCircularChart(
              key: chartKey2,
              holeRadius: 87,
              size: const Size(310, 100),
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(
                      purchaseToProcess,
                      TmColors.accent,
                      rankKey: 'completed',
                    ),
                    CircularSegmentEntry(
                      availableLimit + processedPurchase,
                      Colors.transparent,
                      rankKey: 'remaining',
                    ),
                  ],
                  rankKey: 'progress',
                ),
              ],
              edgeStyle: SegmentEdgeStyle.round,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Container(
            alignment: Alignment.center,
            child: AnimatedCircularChart(
              key: chartKey3,
              holeRadius: 87,
              startAngle: (purchaseToProcess / (usedLimit + availableLimit)) * 360 - 90,
              size: const Size(310, 100),
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(
                      processedPurchase,
                      TmColors.waterBlue,
                      rankKey: 'completed',
                    ),
                    CircularSegmentEntry(
                      availableLimit + purchaseToProcess,
                      Colors.transparent,
                      rankKey: 'remaining',
                    ),
                  ],
                  rankKey: 'progress',
                ),
              ],
              edgeStyle: SegmentEdgeStyle.round,
            ),
          ),
        ),
      ],
    );
  }
}
