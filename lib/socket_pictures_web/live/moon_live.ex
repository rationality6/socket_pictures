defmodule SocketPicturesWeb.MoonLive do
  use Phoenix.LiveView
  alias SocketPicturesWeb.Router.Helpers, as: Routes

  defp moons(), do: ["🌑", "🌒", "🌓", "🌔", "🌝", "🌖", "🌗", "🌘"]
  defp moons_count(), do: moons() |> Enum.count()

  def render(assigns) do
    ~L"""
      <button class="m-2 bg-transparent hover:bg-yellow-500 text-yellow-700 font-semibold hover:text-white py-2 px-4 border border-yellow-500 hover:border-transparent rounded" phx-click="start">
        시작
      </button>
      <button class="m-2 bg-transparent hover:bg-yellow-500 text-yellow-700 font-semibold hover:text-white py-2 px-4 border border-yellow-500 hover:border-transparent rounded" phx-click="stop">
        중단
      </button>
      <button
        class="m-2 bg-transparent hover:bg-yellow-500 text-yellow-700 font-semibold hover:text-white py-2 px-4 border border-yellow-500 hover:border-transparent rounded"
        phx-click="test"
      >
        Test
      </button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("start", _, socket) do
    socket =
      socket
      |> assign(:moon_idx, 0)

    :timer.send_interval(500, self(), :next_moon)

    {:noreply, socket}
  end

  def handle_event("stop", _, socket) do
    Process.cancel_timer(:next_moon)
    {:noreply, socket}
  end

  def handle_event("test", _, socket) do
    {:noreply,
     push_patch(socket,
       to: Routes.live_path(socket, SocketPicturesWeb.MoonLive, "🌝")
     )}
  end

  def handle_info(:next_moon, socket) do
    idx = rem(socket.assigns.moon_idx, moons_count())
    moon = Enum.at(moons(), idx)
    socket = assign(socket, :moon_idx, idx + 1)

    {:noreply,
     push_patch(socket,
       to: Routes.live_path(socket, SocketPicturesWeb.MoonLive, moon)
     )}
  end
end
