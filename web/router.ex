defmodule Thebar.Router do
  use Thebar.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Thebar do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/drinks", DrinkController
    resources "/ingredients", IngredientController
    resources "/categories", CategoryController
    resources "/recipes", RecipeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Thebar do
  #   pipe_through :api
  # end
end
