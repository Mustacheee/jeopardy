defmodule Jeopardy.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string, null: false
      add :answer, :string, null: false
      add :category_id, references(:categories, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:questions, [:category_id])
  end
end
