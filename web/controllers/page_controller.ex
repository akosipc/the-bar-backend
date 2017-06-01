defmodule Thebar.PageController do
  use Thebar.Web, :controller

  alias Thebar.{ Ingredient, Recipe, Drink }

  def index(conn, _) do
    category_ids = Repo.all(from i in Ingredient, where: i.available == true, select: i.category_id)
    drink_ids = Repo.all(from r in Recipe, where: r.category_id in ^category_ids, select: r.drink_id)
    drinks = Repo.all(from d in Drink, where: d.id in ^drink_ids)

    render conn, "index.html", drinks: drinks
  end
end
