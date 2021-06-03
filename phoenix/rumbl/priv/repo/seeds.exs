# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Changeset
alias Rumbl.Multimedia
alias Rumbl.Repo

for category <- ~w(Action Drama Romance Comedy Sci-fi) do
  Multimedia.create_category!(category)
end

for video <- Multimedia.list_videos() do
  changeset =
    Multimedia.change_video(video)
    |> put_change(:slug, video.title |> String.downcase() |> String.replace(~r/[^\w-]+/u, "-"))

    Repo.update(changeset)
end
