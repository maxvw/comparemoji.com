defmodule Comparemoji.Emojis.Data do
  @moduledoc """
  Data source and lookup for all emojis

  This will read the emojis json file into ETS and provides
  access to a quick lookup function.
  """

  alias Comparemoji.Emojis.Emoji

  @table_name :emojis
  @emojis File.read!("priv/emojis.json")
          |> Jason.decode!(keys: :atoms)
          |> Enum.map(&struct(%Emoji{}, &1))

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Initialises the GenServer and either retrieves a reference
  to an existing ets table or creates a new one.
  """
  def init(_) do
    table =
      case :ets.whereis(@table_name) do
        :undefined -> create_table()
        reference -> reference
      end

    {:ok, table}
  end

  def lookup(grapheme) do
    GenServer.call(__MODULE__, {:lookup, grapheme})
  end

  def handle_call({:lookup, grapheme}, _from, table) do
    result =
      case :ets.lookup(table, grapheme) do
        [] -> nil
        [{_key, %Emoji{} = emoji}] -> emoji
        _ -> nil
      end

    {:reply, result, table}
  end

  defp create_table do
    table = :ets.new(@table_name, [:set, :named_table])

    @emojis
    |> Enum.each(&:ets.insert(table, {&1.unicode, &1}))

    table
  end
end
