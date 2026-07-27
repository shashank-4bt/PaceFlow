import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:paceflow/app/theme/app_colors.dart';
import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/core/utils/formatters.dart';
import 'package:paceflow/features/history/presentation/controllers/history_controller.dart';
import 'package:paceflow/features/history/presentation/widgets/route_replay_controller.dart';
import 'package:paceflow/features/history/presentation/widgets/route_replay_map.dart';
import 'package:paceflow/features/settings/presentation/controllers/settings_controller.dart';
import 'package:paceflow/shared/widgets/glass_container.dart';
import 'package:paceflow/shared/widgets/pf_app_bar.dart';
import 'package:paceflow/shared/widgets/stat_chip.dart';

enum MapStyleOption { normal, satellite, terrain, dark }

class WalkDetailPage extends ConsumerStatefulWidget {
  const WalkDetailPage({super.key, required this.walkId});

  final String walkId;

  static const routePath = '/walk/:id';
  static const routeName = 'walkDetail';

  @override
  ConsumerState<WalkDetailPage> createState() => _WalkDetailPageState();
}

class _WalkDetailPageState extends ConsumerState<WalkDetailPage> {
  MapStyleOption _mapStyle = MapStyleOption.normal;
  String? _darkStyleJson;
  RouteReplayController? _replayController;

  @override
  void initState() {
    super.initState();
    _loadDarkStyle();
  }

  Future<void> _loadDarkStyle() async {
    final json = await rootBundle.loadString('assets/map_styles/dark_map.json');
    if (mounted) setState(() => _darkStyleJson = json);
  }

  @override
  void dispose() {
    _replayController?.dispose();
    super.dispose();
  }

  MapType _mapType() {
    switch (_mapStyle) {
      case MapStyleOption.satellite:
        return MapType.satellite;
      case MapStyleOption.terrain:
        return MapType.terrain;
      default:
        return MapType.normal;
    }
  }

  String? _styleJson() {
    if (_mapStyle == MapStyleOption.dark) return _darkStyleJson;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final walkAsync = ref.watch(walkDetailProvider(widget.walkId));
    final useMiles = ref.watch(settingsControllerProvider).usesMiles;
    final theme = Theme.of(context);

    return walkAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: PfAppBar(
          title: 'Walk Detail',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(child: Text(e.toString())),
      ),
      data: (walk) {
        if (walk == null) {
          return Scaffold(
            appBar: PfAppBar(
              title: 'Walk Detail',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
            body: const Center(child: Text('Walk not found')),
          );
        }

        _replayController ??= RouteReplayController(points: walk.points);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share_rounded),
                    onPressed: () =>
                        context.push('/walk/${walk.id}/share'),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: RouteReplayMap(
                    points: walk.points,
                    controller: _replayController!,
                    mapStyle: _styleJson(),
                    mapType: _mapType(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacings.pageInsets,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        walk.title ?? Formatters.dateShort(walk.startedAt),
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        Formatters.dateTimeShort(walk.startedAt),
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSpacings.md),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: MapStyleOption.values.map((option) {
                            final selected = _mapStyle == option;
                            return Padding(
                              padding: const EdgeInsets.only(right: AppSpacings.sm),
                              child: ChoiceChip(
                                label: Text(option.name),
                                selected: selected,
                                onSelected: (_) =>
                                    setState(() => _mapStyle = option),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: AppSpacings.lg),
                      Wrap(
                        spacing: AppSpacings.sm,
                        runSpacing: AppSpacings.sm,
                        children: [
                          StatChip(
                            label: 'Distance',
                            value: Formatters.distanceMeters(
                              walk.distanceMeters,
                              useMiles: useMiles,
                            ),
                          ),
                          StatChip(
                            label: 'Duration',
                            value: Formatters.durationMs(walk.durationMs),
                          ),
                          StatChip(
                            label: 'Pace',
                            value: Formatters.paceSecPerUnit(
                              walk.avgPaceSecPerKm,
                              useMiles: useMiles,
                            ),
                            accentColor: AppColors.electricBlue,
                          ),
                          StatChip(
                            label: 'Calories',
                            value: Formatters.calories(walk.caloriesKcal),
                            accentColor: AppColors.sunsetOrange,
                          ),
                          StatChip(
                            label: 'Elevation',
                            value:
                                '+${Formatters.elevationMeters(walk.elevationGainM, useMiles: useMiles)}',
                            accentColor: AppColors.purple,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacings.lg),
                      ListenableBuilder(
                        listenable: _replayController!,
                        builder: (context, _) {
                          return GlassContainer(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Route Replay',
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _replayController!.isPlaying
                                          ? _replayController!.pause
                                          : _replayController!.play,
                                      icon: Icon(
                                        _replayController!.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _replayController!.reset,
                                      icon: const Icon(Icons.replay_rounded),
                                    ),
                                  ],
                                ),
                                Slider(
                                  value: _replayController!.progress,
                                  onChanged: _replayController!.seek,
                                  activeColor: AppColors.emerald,
                                ),
                              ],
                            ),
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
      },
    );
  }
}
