defmodule Thebar.IngredientController do
  use Thebar.Web, :controller

  plug :scrub_params, "ingredient" when action in [:create, :update]

  alias Thebar.{ Ingredient, Category }

  def index(conn, _) do
    ingredients = 
      Repo.all(Ingredient) 
      |> Repo.preload(:category)

    render(conn, "index.html", ingredients: ingredients)
  end

  def new(conn, _) do
    changeset = Ingredient.changeset(%Ingredient{})
    categories = categories_for_select_options

    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def edit(conn, %{"id" => id}) do
    ingredient = Repo.get!(Ingredient, id)
    changeset = Ingredient.changeset(ingredient)
    categories = categories_for_select_options

    render(conn, "edit.html", changeset: changeset, ingredient: ingredient, categories: categories)
  end

  def show(conn, %{"id" => id}) do
    ingredient = Repo.get!(Ingredient, id)

    render(conn, "show.html", ingredient: ingredient)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    changeset = Ingredient.changeset(%Ingredient{}, ingredient_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created a ingredient") 
        |> redirect(to: ingredient_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("new.html", changeset: changeset, categories: categories_for_select_options)
    end
  end

  def update(conn, %{"id" => id, "ingredient" => ingredient_params}) do
    ingredient = Repo.get!(Ingredient, id)
    changeset = Ingredient.changeset(ingredient, ingredient_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully updated a ingredient") 
        |> redirect(to: ingredient_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("edit.html", ingredient: ingredient, changeset: changeset, categories: categories_for_select_options)
    end
  end

  defp categories_for_select_options do
    Repo.all(Category)
    |> Enum.map( fn (category) -> 
      {category.name, category.id}
    end)
  end
end
