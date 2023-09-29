class Finance {
  const Finance(
      {this.id,
      required this.date,
      required this.nominal,
      required this.keterangan,
      required this.kategori});

  final int? id;
  final String date;
  final int? nominal;
  final String keterangan;
  final String kategori;

  factory Finance.fromJson(Map<String, dynamic> json) => Finance(
        id: json['id'],
        date: json['date'],
        nominal: json['nominal'],
        keterangan: json['keterangan'],
        kategori: json['kategori'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'nominal': nominal,
        'keterangan': keterangan,
        'kategori': kategori
      };
}
