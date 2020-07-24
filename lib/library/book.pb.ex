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
          title: String.t(),
          image: String.t(),
          info: String.t()
        }
  defstruct [:title, :image, :info]

  field :title, 1, type: :string
  field :image, 2, type: :string
  field :info, 3, type: :string
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
