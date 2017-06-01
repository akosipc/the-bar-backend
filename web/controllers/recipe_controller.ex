defmodule Thebar.RecipeController do
  use Thebar.Web, :controller

  alias Thebar.{ Drink, Recipe, Category }

  plug :scrub_params, "recipe" when action in [:create, :update]

  def new(conn, %{"drink_id" => drink_id}) do
    drink = Repo.get!(Drink, drink_id)
    changeset = Recipe.changeset(%Recipe{})

    render(conn, "new.html", changeset: changeset, drink: drink, categories: categories_as_select_options)
  end

  def edit(conn, %{"drink_id" => drink_id, "id" => id}) do
    drink = Repo.get!(Drink, drink_id)
    recipe = Repo.get!(Recipe, id)
    changeset = Recipe.changeset(recipe)

    render(conn, "edit.html", changeset: changeset, recipe: recipe, drink: drink, categories: categories_as_select_options)
  end

  def create(conn, %{"drink_id" => drink_id, "recipe" => recipe_params}) do
    drink = Repo.get!(Drink, drink_id)
    changeset = Recipe.changeset(%Recipe{}, recipe_params) 

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created a recipe") 
        |> redirect(to: drink_path(conn, :show, drink))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("new.html", changeset: changeset, drink: drink, categories: categories_as_select_options)
    end
  end

  def update(conn, %{"drink_id" => drink_id, "id" => id,  "recipe" => recipe_params}) do
    drink = Repo.get!(Drink, drink_id)
    recipe = Repo.get!(Recipe, id)
    changeset = Recipe.changeset(recipe, recipe_params) 

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully updated a recipe") 
        |> redirect(to: drink_path(conn, :show, drink))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("edit.html", changeset: changeset, recipe: recipe, drink: drink, categories: categories_as_select_options)
    end
  end

  defp categories_as_select_options do
    Repo.all(Category)
    |> Enum.map( fn (category) -> 
      {category.name, category.id}
    end)
  end
end
