void main() {
  String? name = null;
  try {
    final first = name?.split(' ').first ?? 'مستخدم';
    final last = name?.split(' ').skip(1).join(' ') ?? '';
    print('First: $first, Last: $last');
  } catch (e) {
    print('Error: $e');
  }
}
