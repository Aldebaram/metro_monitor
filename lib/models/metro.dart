class Metro {
  String situacao;
  String modificado;
  String criado;
  int codigo;
  int id;

  Metro({
    this.situacao,
    this.modificado,
    this.criado,
    this.codigo,
    this.id,
  });

  factory Metro.fromJson(Map<String, dynamic> json){
    return Metro(
      situacao: json['situacao'],
      modificado: json['modificado'],
      criado: json['criado'],
      codigo: json['codigo'],
      id: json['id']
    );
  }
}


