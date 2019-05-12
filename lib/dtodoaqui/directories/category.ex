defmodule Dtodoaqui.Directories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :created, :utc_datetime
    field :font_icon, :string
    field :modified, :utc_datetime
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :slug, :font_icon, :created, :modified])
    |> validate_required([:name, :slug, :font_icon, :created, :modified])
  end
end
