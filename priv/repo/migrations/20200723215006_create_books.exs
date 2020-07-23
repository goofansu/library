defmodule Library.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :isbn, :string
      add :title, :string
      add :image, :string
      add :info, :text

      timestamps()
    end

    create unique_index(:books, [:isbn])
  end
end
