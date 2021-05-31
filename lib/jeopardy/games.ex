defmodule Jeopardy.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Jeopardy.Repo

  alias Jeopardy.Games.Game
  alias Jeopardy.Accounts.User

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  def get_game(id) do
    Game
    |> Repo.get(id)
    |> Repo.preload([:categories, :config])
    |> IO.inspect()
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id) do
    Game
    |> Repo.get!(id)
    |> Repo.preload([:categories])
  end

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def get_user_games(%User{id: user_id}), do: get_user_games(user_id)
  def get_user_games(user_id) when is_binary(user_id) do
    from(g in Game, where: g.user_id == ^user_id, preload: :categories)
    |> Repo.all()
  end
  def get_user_games(_), do: []

  alias Jeopardy.Games.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  def get_category(id), do: Repo.get!(Category, id)

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
    |> broadcast_category("new_category")
  end

  defp broadcast_category({:ok, %Category{game_id: game_id} = category}, event_name) do
    JeopardyWeb.Endpoint.broadcast("game:#{game_id}", event_name, %{category: category})
    {:ok, category}
  end

  defp broadcast_category(category, _event_name), do: category |> IO.inspect()

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    category
    |> Repo.delete()
    |> broadcast_category("delete_category")
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  def get_category_details(category_id) do
    category_id
    |> get_category()
    |> Repo.preload(:questions)
  end

  alias Jeopardy.Games.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
    |> broadcast_question("new_question")
  end

  defp broadcast_question({:ok, %Question{category_id: category_id} = question}, event_name) do
    category_id
    |> get_category()
    |> case do
      %Category{game_id: game_id} ->
        JeopardyWeb.Endpoint.broadcast("game:#{game_id}", event_name, %{question: question})
      _ ->
        nil
    end
    {:ok, question}
  end

  defp broadcast_question(question, _event_name), do: question |> IO.inspect()

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  alias Jeopardy.Games.GameConfig

  @doc """
  Returns the list of game_configs.

  ## Examples

      iex> list_game_configs()
      [%GameConfig{}, ...]

  """
  def list_game_configs do
    Repo.all(GameConfig)
  end

  @doc """
  Gets a single game_config.

  Raises `Ecto.NoResultsError` if the Game config does not exist.

  ## Examples

      iex> get_game_config!(123)
      %GameConfig{}

      iex> get_game_config!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game_config!(id), do: Repo.get!(GameConfig, id)

  @doc """
  Creates a game_config.

  ## Examples

      iex> create_game_config(%{field: value})
      {:ok, %GameConfig{}}

      iex> create_game_config(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game_config(attrs \\ %{}) do
    %GameConfig{}
    |> GameConfig.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game_config.

  ## Examples

      iex> update_game_config(game_config, %{field: new_value})
      {:ok, %GameConfig{}}

      iex> update_game_config(game_config, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game_config(%GameConfig{} = game_config, attrs) do
    game_config
    |> GameConfig.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game_config.

  ## Examples

      iex> delete_game_config(game_config)
      {:ok, %GameConfig{}}

      iex> delete_game_config(game_config)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game_config(%GameConfig{} = game_config) do
    Repo.delete(game_config)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game_config changes.

  ## Examples

      iex> change_game_config(game_config)
      %Ecto.Changeset{data: %GameConfig{}}

  """
  def change_game_config(%GameConfig{} = game_config, attrs \\ %{}) do
    GameConfig.changeset(game_config, attrs)
  end
end
