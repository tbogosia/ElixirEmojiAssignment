defmodule EmojiWeb.PopularityStore do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get_most_popular(to_take \\ 5) do
    Agent.get(__MODULE__, fn state -> state end)
    |> Map.to_list()
    |> Enum.sort(&(Kernel.elem(&1, 1) > Kernel.elem(&2, 1)))
    |> Enum.take(to_take)
    |> Enum.map(&(Kernel.elem(&1, 0)))
  end

  def inc_popularity(emoji_name) do
    Agent.update(__MODULE__, fn state ->
      Map.update(state, emoji_name, 1, &(&1 + 1))
    end)
  end

  def get(emoji_name) do
    Agent.get(__MODULE__, &Map.get(&1, emoji_name))
  end

end
