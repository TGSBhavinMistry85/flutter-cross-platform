class DepartmentStats {
  final int total;
  final int active;
  final int inactive;
  final int deleted;

  const DepartmentStats({
    required this.total,
    required this.active,
    required this.inactive,
    required this.deleted,
  });

  factory DepartmentStats.empty() {
    return const DepartmentStats(
      total: 0,
      active: 0,
      inactive: 0,
      deleted: 0,
    );
  }
}