defmodule DemoWeb.FormAutocompleteLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form phx-change="suggest" phx-submit="search">
      <input type="text" name="q" value="<%= @query %>" list="matches" placeholder="Search..." <%= if @loading, do: "readonly" %> />
      <datalist id="matches">
        <%= for match <- @matches do %>
          <option value="<%= match %>"><%= match %></option>
        <% end %>
      </datalist>

      <%= if @result do %><pre><%= @result %></pre><% end %>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        query: "",
        loading: false,
        matches: [],
        result: ""
      )
    }
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) <= 100 do
    {words, _} = System.cmd("grep", ["^#{query}.*", "-m", "5", "/usr/share/dict/words"])

    {:noreply, assign(socket, matches: String.split(words, "\n"))}
  end

  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
    send(self(), {:search, query})

    {
      :noreply,
      assign(
        socket,
        query: query,
        result: "Searching...",
        loading: true,
        matches: []
      )
    }
  end

  def handle_info({:search, _query}, socket) do
    :timer.sleep(2)

    {
      :noreply,
      assign(
        socket,
        query: "",
        result: "Searched!",
        loading: false,
        matches: []
      )
    }
  end
end
