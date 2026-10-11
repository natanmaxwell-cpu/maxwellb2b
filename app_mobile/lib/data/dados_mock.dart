import '../models/tarefa.dart';
import '../models/treinamento.dart';

final tarefas = <Tarefa>[
  Tarefa(id: 1, titulo: 'Assinar documento', subtitulo: 'Aprovação de documentos', solicitante: 'Marcelo', departamento: 'Compras', data: '25/09/2026', descricao: 'Aprovação de documentos para compra de equipamentos.', status: StatusTarefa.pendente),
  Tarefa(id: 2, titulo: 'Cliente - José', subtitulo: 'Analisar solicitação do cliente', solicitante: 'José', departamento: 'Comercial', data: '26/09/2026', descricao: 'Verificar e validar a solicitação apresentada pelo cliente.', status: StatusTarefa.pendente),
  Tarefa(id: 3, titulo: 'Causas étnico-raciais', subtitulo: 'Revisar treinamento', solicitante: 'RH', departamento: 'Recursos Humanos', data: '27/09/2026', descricao: 'Revisar informações relacionadas ao treinamento.', status: StatusTarefa.pendente),
  Tarefa(id: 4, titulo: 'Bate-papo - cliente novo', subtitulo: 'Contato inicial', solicitante: 'Comercial', departamento: 'Comercial', data: '28/09/2026', descricao: 'Realizar contato inicial com novo cliente.', status: StatusTarefa.emAndamento),
  Tarefa(id: 5, titulo: 'Bate-papo - causas raciais', subtitulo: 'Discussão interna', solicitante: 'RH', departamento: 'Recursos Humanos', data: '29/09/2026', descricao: 'Participar da discussão interna sobre o tema.', status: StatusTarefa.emAndamento),
  Tarefa(id: 6, titulo: 'Treinamento - ética no trabalho', subtitulo: 'Treinamento obrigatório', solicitante: 'RH', departamento: 'Recursos Humanos', data: '20/09/2026', descricao: 'Treinamento sobre ética e conduta profissional.', status: StatusTarefa.concluida),
];

final treinamentos = <Treinamento>[
  Treinamento(id: 1, titulo: 'Diversidade e Relações Étnico-Raciais', categoria: 'Responsabilidade social', progresso: 60),
  Treinamento(id: 2, titulo: 'Ética no Trabalho', categoria: 'Conduta profissional', progresso: 100),
];
