defmodule Library.Inventory.Book do
  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Changeset

  schema "books" do
    field :image, Library.ImageUploader.Type
    field :info, :string
    field :isbn, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn, :title, :info])
    |> cast_attachments(attrs, [:image], allow_urls: true)
    |> validate_required([:isbn])
    |> unique_constraint(:isbn)
  end
end
