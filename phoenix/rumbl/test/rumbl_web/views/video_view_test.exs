defmodule RumblWeb.VideoViewTest do
  use RumblWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    videos = [
      %Rumbl.Multimedia.Video{id: "1", title: "dogs"},
      %Rumbl.Multimedia.Video{id: "2", title: "cats"}
    ]

    content = render_to_string(
      RumblWeb.VideoView,
      "index.html",
      conn: conn,
      videos: videos
    )

    assert String.contains?(content, "Listing Videos")

    for video <- videos do
      assert String.contains?(content, video.title)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Rumbl.Multimedia.change_video(%Rumbl.Multimedia.Video{})

    categories = [%Rumbl.Multimedia.Category{id: 123, name: "cats"}]

    content = render_to_string(
      RumblWeb.VideoView,
      "new.html",
      conn: conn,
      changeset: changeset,
      categories: categories
    )

    assert String.contains?(content, "New Video")
  end

  test "renders show.html", %{conn: conn} do
    owner = user_fixture()
    video = video_fixture(owner)

    content = render_to_string(
      RumblWeb.VideoView,
      "show.html",
      conn: conn,
      video: video
    )

    assert String.contains?(content, "Show Video")

    assert String.contains?(content, video.title)
    assert String.contains?(content, video.url)
    assert String.contains?(content, video.description)
  end
end
