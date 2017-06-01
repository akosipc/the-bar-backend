defmodule Thebar.CategoryController do
  use Thebar.Web, :controller

  plug :scrub_params, "category" when action in [:create, :update]

  alias Thebar.Category 

  def index(conn, _) do
    categories = Repo.all(Category)

    render(conn, "index.html", categories: categories)
  end

  def new(conn, _) do
    changeset = Category.changeset(%Category{})

    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category)

    render(conn, "edit.html", changeset: changeset, category: category)
  end

  def create(conn, %{"category" => category_params}) do
    changeset = Category.changeset(%Category{}, category_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created a category") 
        |> redirect(to: category_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category, category_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully updated a category") 
        |> redirect(to: category_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("edit.html", category: category, changeset: changeset)
    end
  end
end
