import 'package:battlestats/app/app_viewmodel.dart';
import 'package:battlestats/data/local/player_repository.dart';
import 'package:battlestats/data/remote/player_service.dart';
import 'package:battlestats/data/remote/stats_service.dart';
import 'package:battlestats/data/repository/stats_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockPlayerRepo extends Mock implements PlayerRepository {}

class MockPlayerService extends Mock implements PlayerService {}

class MockStatsService extends Mock implements StatsService {}

class MockAppViewModel extends Mock implements AppViewModel {}

class MockStatsRepo extends Mock implements StatsRepository {}