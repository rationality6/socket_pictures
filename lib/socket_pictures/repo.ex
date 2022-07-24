defmodule SocketPictures.Repo do
  use Ecto.Repo,
    otp_app: :socket_pictures,
    adapter: Ecto.Adapters.Postgres
end
