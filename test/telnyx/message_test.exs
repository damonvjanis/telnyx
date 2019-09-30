defmodule Telnyx.MessagesTest do
  use ExUnit.Case, async: true

  @test_key "KEYSUPERSECRET"

  @valid_params %{
    messaging_profile_id: "test_messaging_profile_id",
    from: "+18665552368",
    to: "+18445552367",
    text: "Hello world"
  }

  @invalid_params %{}

  @uuid "uuid"

  describe "create/2" do
    test "fails without required params" do
      {:error, failed_result} = Telnyx.Messages.create(@test_key, @invalid_params)

      assert failed_result.__struct__ == Telnyx.Error
    end

    test "succeeds with valid params" do
      {:ok, successful_result} = Telnyx.Messages.create(@test_key, @valid_params)

      assert successful_result["text"] == "Hello world"
    end
  end

  describe "retrieve/2" do
    test "fails without a uuid" do
      refute match?({:ok, _}, Telnyx.Messages.retrieve(@test_key, nil))
      refute match?({:ok, _}, Telnyx.Messages.retrieve(@test_key, ""))
    end

    test "succeeds with valid uid" do
      assert match?({:ok, _}, Telnyx.Messages.retrieve(@test_key, @uuid))
    end
  end
end
