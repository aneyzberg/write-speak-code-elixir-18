defmodule MyApp.Router do
  use Plug.Router
  plug(:match)

  plug Plug.Parsers,
  parsers: [:json],
  pass: ["*/*"],
  json_decoder: Poison

  plug(:dispatch)

  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link() do
    {:ok, _} = Plug.Adapters.Cowboy2.http(MyApp.Router, [], port: 4000)
  end

  get("/:name") do
    query_params = Plug.Conn.fetch_query_params(conn)
    name =  query_params.params["name"] || 1
    character = MyApp.ApiHandler.get_character(name)
    conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, character)
  end

  get "/" do
    conn
    |> send_resp(200, "yay")
    |> halt
  end

  match _ do
    conn
    |> send_resp(404, "Not found")
  end
end
