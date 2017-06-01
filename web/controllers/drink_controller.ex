defmodule Thebar.DrinkController do
  use Thebar.Web, :controller

  plug :scrub_params, "drink" when action in [:create, :update]

  alias Thebar.Drink

  def index(conn, _) do
    drinks = Repo.all(Drink)

    render(conn, "index.html", drinks: drinks)
  end

  def new(conn, _) do
    changeset = Drink.changeset(%Drink{})

    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    drink = Repo.get!(Drink, id)
    changeset = Drink.changeset(drink)

    render(conn, "edit.html", changeset: changeset, drink: drink)
  end

  def show(conn, %{"id" => id}) do
    drink = 
      Repo.get!(Drink, id)
      |> Repo.preload([recipes: :category])

    render(conn, "show.html", drink: drink)
  end

  def create(conn, %{"drink" => drink_params}) do
    changeset = Drink.changeset(%Drink{}, drink_params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created a drink") 
        |> redirect(to: drink_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "drink" => drink_params}) do
    drink = Repo.get!(Drink, id)
    changeset = Drink.changeset(drink, drink_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully updated a drink") 
        |> redirect(to: drink_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There where some errors encountered")
        |> render("edit.html", drink: drink, changeset: changeset)
    end
  end
end
