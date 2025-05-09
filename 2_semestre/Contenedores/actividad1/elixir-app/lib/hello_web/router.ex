defmodule HelloWeb.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hola desde Elixir en Docker")
  end

  match _ do
    send_resp(conn, 404, "No encontrado")
  end
end
