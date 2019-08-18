defmodule Telnyx.Error do
  defexception [:message, :status_code]

  @type t :: Telnyx.error()
end
