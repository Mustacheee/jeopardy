defmodule Jeopardy.GamesTest do
  use Jeopardy.DataCase

  alias Jeopardy.Games

  describe "games" do
    alias Jeopardy.Games.Game

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "categories" do
    alias Jeopardy.Games.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Games.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Games.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Games.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Games.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_category(category, @invalid_attrs)
      assert category == Games.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Games.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Games.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Games.change_category(category)
    end
  end

  describe "questions" do
    alias Jeopardy.Games.Question

    @valid_attrs %{answer: "some answer", text: "some text"}
    @update_attrs %{answer: "some updated answer", text: "some updated text"}
    @invalid_attrs %{answer: nil, text: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Games.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Games.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = Games.create_question(@valid_attrs)
      assert question.answer == "some answer"
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = Games.update_question(question, @update_attrs)
      assert question.answer == "some updated answer"
      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_question(question, @invalid_attrs)
      assert question == Games.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Games.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Games.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Games.change_question(question)
    end
  end

  describe "game_configs" do
    alias Jeopardy.Games.GameConfig

    @valid_attrs %{column_count: 42, qs_per_category: 42}
    @update_attrs %{column_count: 43, qs_per_category: 43}
    @invalid_attrs %{column_count: nil, qs_per_category: nil}

    def game_config_fixture(attrs \\ %{}) do
      {:ok, game_config} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game_config()

      game_config
    end

    test "list_game_configs/0 returns all game_configs" do
      game_config = game_config_fixture()
      assert Games.list_game_configs() == [game_config]
    end

    test "get_game_config!/1 returns the game_config with given id" do
      game_config = game_config_fixture()
      assert Games.get_game_config!(game_config.id) == game_config
    end

    test "create_game_config/1 with valid data creates a game_config" do
      assert {:ok, %GameConfig{} = game_config} = Games.create_game_config(@valid_attrs)
      assert game_config.column_count == 42
      assert game_config.qs_per_category == 42
    end

    test "create_game_config/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game_config(@invalid_attrs)
    end

    test "update_game_config/2 with valid data updates the game_config" do
      game_config = game_config_fixture()
      assert {:ok, %GameConfig{} = game_config} = Games.update_game_config(game_config, @update_attrs)
      assert game_config.column_count == 43
      assert game_config.qs_per_category == 43
    end

    test "update_game_config/2 with invalid data returns error changeset" do
      game_config = game_config_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game_config(game_config, @invalid_attrs)
      assert game_config == Games.get_game_config!(game_config.id)
    end

    test "delete_game_config/1 deletes the game_config" do
      game_config = game_config_fixture()
      assert {:ok, %GameConfig{}} = Games.delete_game_config(game_config)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game_config!(game_config.id) end
    end

    test "change_game_config/1 returns a game_config changeset" do
      game_config = game_config_fixture()
      assert %Ecto.Changeset{} = Games.change_game_config(game_config)
    end
  end
end
