defmodule Telnyx.Error do
  defexception [:status_code, :error_code, :source, :message, :meta, :title]
end
