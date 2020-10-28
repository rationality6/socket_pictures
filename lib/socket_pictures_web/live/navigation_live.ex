defmodule SocketPicturesWeb.NavigationLive do
  use SocketPicturesWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, key: "")

    {:ok, socket}
  end

end
