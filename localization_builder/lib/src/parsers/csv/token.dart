import 'package:equatable/equatable.dart';

class CsvLocalizationToken extends Equatable {
  const CsvLocalizationToken({
    required this.row,
    required this.column,
    required this.type,
  });

  const CsvLocalizationToken.unknown(this.row, this.column)
      : type = CsvLocalizationTokenType.unknown;

  final int row;
  final int column;
  final CsvLocalizationTokenType type;

  @override
  List<Object> get props => [
        row,
        column,
        type,
      ];
}

enum CsvLocalizationTokenType {
  unknown,
  key,
}
