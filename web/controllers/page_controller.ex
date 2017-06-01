defmodule Thebar.PageController do
  use Thebar.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
