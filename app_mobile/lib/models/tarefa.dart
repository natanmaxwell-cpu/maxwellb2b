enum StatusTarefa { pendente, emAndamento, concluida }

class Tarefa {
  final int id;
  final String titulo;
  final String subtitulo;
  final String solicitante;
  final String departamento;
  final String data;
  final String descricao;
  StatusTarefa status;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.subtitulo,
    required this.solicitante,
    required this.departamento,
    required this.data,
    required this.descricao,
    required this.status,
  });
}
