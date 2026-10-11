
using Microsoft.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

var connectionString =
    @"Server=localhost\SQLEXPRESS;Database=MaxwellB2B;Integrated Security=True;TrustServerCertificate=True;";

app.MapGet("/api/tarefas", async () =>
{
    var tarefas = new List<Tarefa>();

    await using var conexao = new SqlConnection(connectionString);
    await conexao.OpenAsync();

    const string sql =
        "SELECT Id, Titulo, Status FROM Tarefas ORDER BY Id";

    await using var comando = new SqlCommand(sql, conexao);
    await using var leitor = await comando.ExecuteReaderAsync();

    while (await leitor.ReadAsync())
    {
        tarefas.Add(new Tarefa
        {
            Id = leitor.GetInt32(0),
            Titulo = leitor.GetString(1),
            Status = leitor.GetString(2)
        });
    }

    return Results.Ok(tarefas);
});

app.MapPut("/api/tarefas/{id:int}/status",
    async (int id, AtualizarStatusRequest requisicao) =>
{
    var statusPermitidos = new[]
    {
        "Pendente",
        "Em andamento",
        "Concluída"
    };

    if (string.IsNullOrWhiteSpace(requisicao.Status) ||
        !statusPermitidos.Contains(requisicao.Status))
    {
        return Results.BadRequest(new
        {
            mensagem = "Status inválido."
        });
    }

    await using var conexao = new SqlConnection(connectionString);
    await conexao.OpenAsync();

    const string sql =
        "UPDATE Tarefas SET Status = @Status WHERE Id = @Id";

    await using var comando = new SqlCommand(sql, conexao);

    comando.Parameters.AddWithValue("@Status", requisicao.Status);
    comando.Parameters.AddWithValue("@Id", id);

    var linhasAfetadas = await comando.ExecuteNonQueryAsync();

    if (linhasAfetadas == 0)
    {
        return Results.NotFound(new
        {
            mensagem = "Tarefa não encontrada."
        });
    }

    return Results.Ok(new
    {
        id,
        status = requisicao.Status,
        mensagem = "Status atualizado com sucesso."
    });
});

app.Run();

public class Tarefa
{
    public int Id { get; set; }
    public string Titulo { get; set; } = "";
    public string Status { get; set; } = "";
}

public class AtualizarStatusRequest
{
    public string Status { get; set; } = "";
}
