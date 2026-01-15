class HomeStats {
  final int total;
  final int active;
  final int inactive;
  final int deleted;

  const HomeStats({
    required this.total,
    required this.active,
    required this.inactive,
    required this.deleted,
  });

  factory HomeStats.empty() {
    return const HomeStats(
      total: 0,
      active: 0,
      inactive: 0,
      deleted: 0,
    );
  }
}