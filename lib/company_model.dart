class CompanyModel {
  List<AtividadePrincipal>? atividadePrincipal;
  String? dataSituacao;
  String? tipo;
  String? nome;
  String? uf;
  String? telefone;
  String? email;
  List<AtividadesSecundarias>? atividadesSecundarias;
  List<Qsa>? qsa;
  String? situacao;
  String? bairro;
  String? logradouro;
  String? numero;
  String? cep;
  String? municipio;
  String? porte;
  String? abertura;
  String? naturezaJuridica;
  String? cnpj;
  String? ultimaAtualizacao;
  String? status;
  String? fantasia;
  String? complemento;
  String? efr;
  String? motivoSituacao;
  String? situacaoEspecial;
  String? dataSituacaoEspecial;
  String? capitalSocial;
  Extra? extra;
  Billing? billing;

  CompanyModel({
    this.atividadePrincipal,
    this.dataSituacao,
    this.tipo,
    this.nome,
    this.uf,
    this.telefone,
    this.email,
    this.atividadesSecundarias,
    this.qsa,
    this.situacao,
    this.bairro,
    this.logradouro,
    this.numero,
    this.cep,
    this.municipio,
    this.porte,
    this.abertura,
    this.naturezaJuridica,
    this.cnpj,
    this.ultimaAtualizacao,
    this.status,
    this.fantasia,
    this.complemento,
    this.efr,
    this.motivoSituacao,
    this.situacaoEspecial,
    this.dataSituacaoEspecial,
    this.capitalSocial,
    this.extra,
    this.billing,
  });

  CompanyModel.fromJson(Map<String, dynamic> json) {
    atividadePrincipal = (json['atividade_principal'] as List?)?.map((dynamic e) => AtividadePrincipal.fromJson(e as Map<String,dynamic>)).toList();
    dataSituacao = json['data_situacao'] as String?;
    tipo = json['tipo'] as String?;
    nome = json['nome'] as String?;
    uf = json['uf'] as String?;
    telefone = json['telefone'] as String?;
    email = json['email'] as String?;
    atividadesSecundarias = (json['atividades_secundarias'] as List?)?.map((dynamic e) => AtividadesSecundarias.fromJson(e as Map<String,dynamic>)).toList();
    qsa = (json['qsa'] as List?)?.map((dynamic e) => Qsa.fromJson(e as Map<String,dynamic>)).toList();
    situacao = json['situacao'] as String?;
    bairro = json['bairro'] as String?;
    logradouro = json['logradouro'] as String?;
    numero = json['numero'] as String?;
    cep = json['cep'] as String?;
    municipio = json['municipio'] as String?;
    porte = json['porte'] as String?;
    abertura = json['abertura'] as String?;
    naturezaJuridica = json['natureza_juridica'] as String?;
    cnpj = json['cnpj'] as String?;
    ultimaAtualizacao = json['ultima_atualizacao'] as String?;
    status = json['status'] as String?;
    fantasia = json['fantasia'] as String?;
    complemento = json['complemento'] as String?;
    efr = json['efr'] as String?;
    motivoSituacao = json['motivo_situacao'] as String?;
    situacaoEspecial = json['situacao_especial'] as String?;
    dataSituacaoEspecial = json['data_situacao_especial'] as String?;
    capitalSocial = json['capital_social'] as String?;
    extra = (json['extra'] as Map<String,dynamic>?) != null ? Extra.fromJson(json['extra'] as Map<String,dynamic>) : null;
    billing = (json['billing'] as Map<String,dynamic>?) != null ? Billing.fromJson(json['billing'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['atividade_principal'] = atividadePrincipal?.map((e) => e.toJson()).toList();
    json['data_situacao'] = dataSituacao;
    json['tipo'] = tipo;
    json['nome'] = nome;
    json['uf'] = uf;
    json['telefone'] = telefone;
    json['email'] = email;
    json['atividades_secundarias'] = atividadesSecundarias?.map((e) => e.toJson()).toList();
    json['qsa'] = qsa?.map((e) => e.toJson()).toList();
    json['situacao'] = situacao;
    json['bairro'] = bairro;
    json['logradouro'] = logradouro;
    json['numero'] = numero;
    json['cep'] = cep;
    json['municipio'] = municipio;
    json['porte'] = porte;
    json['abertura'] = abertura;
    json['natureza_juridica'] = naturezaJuridica;
    json['cnpj'] = cnpj;
    json['ultima_atualizacao'] = ultimaAtualizacao;
    json['status'] = status;
    json['fantasia'] = fantasia;
    json['complemento'] = complemento;
    json['efr'] = efr;
    json['motivo_situacao'] = motivoSituacao;
    json['situacao_especial'] = situacaoEspecial;
    json['data_situacao_especial'] = dataSituacaoEspecial;
    json['capital_social'] = capitalSocial;
    json['extra'] = extra?.toJson();
    json['billing'] = billing?.toJson();
    return json;
  }
}

class AtividadePrincipal {
  String? text;
  String? code;

  AtividadePrincipal({
    this.text,
    this.code,
  });

  AtividadePrincipal.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
    code = json['code'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['text'] = text;
    json['code'] = code;
    return json;
  }
}

class AtividadesSecundarias {
  String? text;
  String? code;

  AtividadesSecundarias({
    this.text,
    this.code,
  });

  AtividadesSecundarias.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
    code = json['code'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['text'] = text;
    json['code'] = code;
    return json;
  }
}

class Qsa {
  String? qual;
  String? qualRepLegal;
  String? nomeRepLegal;
  String? nome;

  Qsa({
    this.qual,
    this.qualRepLegal,
    this.nomeRepLegal,
    this.nome,
  });

  Qsa.fromJson(Map<String, dynamic> json) {
    qual = json['qual'] as String?;
    qualRepLegal = json['qual_rep_legal'] as String?;
    nomeRepLegal = json['nome_rep_legal'] as String?;
    nome = json['nome'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['qual'] = qual;
    json['qual_rep_legal'] = qualRepLegal;
    json['nome_rep_legal'] = nomeRepLegal;
    json['nome'] = nome;
    return json;
  }
}

class Extra {


  Extra();

Extra.fromJson(Map<String, dynamic> json) {

}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> json = <String, dynamic>{};

  return json;
}
}

class Billing {
  bool? free;
  bool? database;

  Billing({
    this.free,
    this.database,
  });

  Billing.fromJson(Map<String, dynamic> json) {
    free = json['free'] as bool?;
    database = json['database'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['free'] = free;
    json['database'] = database;
    return json;
  }
}