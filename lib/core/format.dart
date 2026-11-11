/// Tiny formatters, hand-rolled to keep `intl` out of the dependency graph.
/// Locale-aware month names land with the later content pack.
library;

const List<String> _months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _two(int value) => value.toString().padLeft(2, '0');

/// `17 Oct 2026`
String formatDay(DateTime date) =>
    '${date.day} ${_months[date.month - 1]} ${date.year}';

/// `17 Oct 2026, 14:05`
String formatDayTime(DateTime date) =>
    '${formatDay(date)}, ${_two(date.hour)}:${_two(date.minute)}';

/// Masked for display: `******6789`.
String maskPhone(String phone) {
  if (phone.length <= 4) return '*' * phone.length;
  return '${'*' * (phone.length - 4)}${phone.substring(phone.length - 4)}';
}
