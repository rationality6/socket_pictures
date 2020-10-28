defmodule SocketPicturesWeb.PicturesLive do
  use Phoenix.LiveView

  @pictures %{
    "ySMOWp3oBZk" => %{
      author: "Ludomił",
      img: "https://images.unsplash.com/photo-1515532718572-84a0ef89c998"
    },
    "svEN_5NXO3o" => %{
      author: "George Desipris",
      img: "https://images.unsplash.com/photo-1520765333005-1966cab37761"
    },
    "XesILKdmkwM" => %{
      author: "Ludomił",
      img: "https://images.unsplash.com/photo-1530717449302-271006cdc1bf"
    },
    "rgAAcndHGBc" => %{
      author: "Yuliya Kosolapova",
      img: "https://images.unsplash.com/photo-1547892549-e197e0456244"
    }
  }
  def mount(_params, _session, socket) do
    socket = assign(socket, :selected_picture, nil)
    {:ok, socket}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    pics = @pictures

    ~L"""
      <div style="display:flex">
        <%= for {id, pic} <- pics do %>
          <div class="column" phx-click="show" phx-value-id="<%= id %>">
            <%= pic.author %>
            <div class="text-sm"><%= id %></div>
            <img class="w-64 object-cover h-32" src="<%= picture_url(pic.img, :thumb) %>">
          </div>
        <% end %>
      </div>

      <%= if @selected_picture do %>
        <br>
        <hr>
        <label><%= @selected_picture.author %></label>
        <img class="w-full" src="<%= picture_url(@selected_picture.img, :big) %>">
      <% end %>
    """
  end

  def handle_event("show", %{"id" => id}, socket) do
    pic = @pictures[id]
    socket = assign(socket, :selected_picture, pic)
    {:noreply, socket}
  end

  defp picture_url(img, :thumb), do: "#{img}?w=250fit=crop"

  defp picture_url(img, :big), do: "#{img}?w=800&h=500fit=crop"
end
