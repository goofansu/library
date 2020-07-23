defmodule Library.BookReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          isbn: String.t()
        }
  defstruct [:isbn]

  field :isbn, 1, type: :string
end

defmodule Library.BookResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          isbn: String.t(),
          title: String.t(),
          image: String.t(),
          info: String.t()
        }
  defstruct [:isbn, :title, :image, :info]

  field :isbn, 1, type: :string
  field :title, 2, type: :string
  field :image, 3, type: :string
  field :info, 4, type: :string
end

defmodule Library.BookService.Service do
  @moduledoc false
  use GRPC.Service, name: "library.BookService"

  rpc :GetBook, Library.BookReq, Library.BookResp
end

defmodule Library.BookService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Library.BookService.Service
end
