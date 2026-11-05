/// Categories accepted by the community report wizard.
///
/// The wire values are provisional until the NestJS contract is confirmed.
enum ReportCategory {
  flood('flood', 'Inundación'),
  damagedDrain('damaged_drain', 'Alcantarilla dañada'),
  fallenTree('fallen_tree', 'Árbol caído'),
  landslide('landslide', 'Deslizamiento'),
  fire('fire', 'Incendio'),
  earthquakeDamage('earthquake_damage', 'Sismo o daños'),
  other('other', 'Otra situación');

  const ReportCategory(this.wireValue, this.label);

  final String wireValue;
  final String label;

  static ReportCategory fromWireValue(String value) {
    final normalized = value.trim().toLowerCase();
    return ReportCategory.values.firstWhere(
      (category) =>
          category.wireValue == normalized || category.name == normalized,
      orElse: () => ReportCategory.other,
    );
  }
}
