defmodule Comparemoji.Application do
  @moduledoc false
  use Application

  def start(:normal, []) do
    [
      {Phoenix.PubSub, name: Comparemoji.PubSub},
      Comparemoji.Emojis.Data,
      Comparemoji.Endpoint
    ]
    |> Supervisor.start_link(strategy: :one_for_one)
  end
end
