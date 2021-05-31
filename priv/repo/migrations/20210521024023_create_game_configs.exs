defmodule Jeopardy.Repo.Migrations.CreateGameConfigs do
  use Ecto.Migration

  def change do
    create table(:game_configs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :column_count, :integer
      add :qs_per_category, :integer
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:game_configs, [:game_id])
  end
end
