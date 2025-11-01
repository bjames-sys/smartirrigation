import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayDate = DateFormat('MMMM, d').format(now);
    final todayDay = DateFormat('EEEE').format(now);

    final forecasts = [
      {
        'date': todayDate,
        'day': todayDay,
        'description': 'Partly Cloudy with Rain',
        'icon': Icons.cloudy_snowing,
        'selected': true,
      },
      {
        'date': DateFormat('MMMM, d').format(now.add(const Duration(days: 1))),
        'day': DateFormat('EEEE').format(now.add(const Duration(days: 1))),
        'description': 'Heavy Rainfall with Thunderstorm',
        'icon': Icons.thunderstorm,
        'selected': false,
      },
      {
        'date': DateFormat('MMMM, d').format(now.add(const Duration(days: 2))),
        'day': DateFormat('EEEE').format(now.add(const Duration(days: 2))),
        'description': 'Cloudy with scattered showers',
        'icon': Icons.cloud,
        'selected': false,
      },
      {
        'date': DateFormat('MMMM, d').format(now.add(const Duration(days: 3))),
        'day': DateFormat('EEEE').format(now.add(const Duration(days: 3))),
        'description': 'Thunderstorms likely',
        'icon': Icons.thunderstorm,
        'selected': false,
      },
      {
        'date': DateFormat('MMMM, d').format(now.add(const Duration(days: 4))),
        'day': DateFormat('EEEE').format(now.add(const Duration(days: 4))),
        'description': 'Sunny and clear skies',
        'icon': Icons.wb_sunny,
        'selected': false,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weather Forecast',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: forecasts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final forecast = forecasts[index];
                    final isSelected = forecast['selected'] as bool;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3B82F6)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  forecast['date'] as String,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  forecast['day'] as String,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.air,
                                      size: 14,
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.black38,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        forecast['description'] as String,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isSelected
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            forecast['icon'] as IconData,
                            size: 48,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF3B82F6),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
