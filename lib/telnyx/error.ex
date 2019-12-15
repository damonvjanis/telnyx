defmodule Telnyx.Error do
  defexception [:status_code, :error_code, :message, :meta, :title]

  @type t :: Telnyx.error()
end
