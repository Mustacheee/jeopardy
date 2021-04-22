defmodule Jeopardy.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false
      add :game_id, references(:games, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:categories, [:user_id, :game_id, :name])
  end
end
