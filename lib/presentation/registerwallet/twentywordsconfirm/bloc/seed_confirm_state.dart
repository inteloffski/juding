import 'package:equatable/equatable.dart';

abstract class StateSeed {}

class InitSeedState extends StateSeed {
}

class ValidSeedState extends StateSeed {
}

class InvalidSeedState extends StateSeed {
}