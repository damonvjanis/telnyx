defmodule Telnyx.MessagingPhoneNumbersTest do
  use ExUnit.Case, async: true

  @test_key "KEYSUPERSECRET"
  @phone "+18665552368"

  describe "list/2" do
    test "succeeds without params" do
      {:ok, list = [first | _]} = Telnyx.MessagingPhoneNumbers.list(@test_key)

      assert is_list(list)
      assert is_map(first)
    end

    test "succeeds with params" do
      # This call succeeds on prod, but the test server doesn't support the params
      # so we're not actually making the call (since it results in an error).

      # Telnyx.MessagingPhoneNumbers.list(@test_key, page: %{size: 10})
    end
  end

  describe "retrieve/2" do
    test "fails without a phone" do
      refute match?({:ok, _}, Telnyx.Messages.retrieve(nil, @test_key))
      refute match?({:ok, _}, Telnyx.Messages.retrieve("", @test_key))
    end

    test "succeeds with valid phone" do
      assert match?({:ok, _}, Telnyx.Messages.retrieve(@phone, @test_key))
    end
  end

  describe "update/2" do
    test "fails without a uuid" do
      params = %{messaging_profile_id: "uuid"}

      refute match?({:ok, _}, Telnyx.MessagingPhoneNumbers.update(params, nil, @test_key))
      refute match?({:ok, _}, Telnyx.MessagingPhoneNumbers.update(params, "", @test_key))
    end

    test "succeeds with valid uid and params" do
      # The test server doesn't support this call currently

      # params = %{messaging_profile_id: "uuid"}
      # assert match?({:ok, _}, Telnyx.MessagingPhoneNumbers.update(params, @uuid, @test_key))
    end
  end
end
