class Details {
  int codigo;
  String criado;
  int id;
  String descricao;
  String situacao;

  Details({
    this.codigo,
    this.criado,
    this.id,
    this.descricao,
    this.situacao,
  });
  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
        situacao: json['situacao'],
        descricao: json['descricao'],
        criado: json['criado'],
        codigo: json['codigo'],
        id: json['id']);
  }
}
