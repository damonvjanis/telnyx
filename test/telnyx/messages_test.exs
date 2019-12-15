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
      assert match?({:error, %Telnyx.Error{}}, Telnyx.Messages.create(@invalid_params, @test_key))
    end

    test "succeeds with valid params" do
      assert match?({:ok, %{"text" => _}}, Telnyx.Messages.create(@valid_params, @test_key))
    end
  end

  describe "create_long_code/2" do
    test "fails without required params" do
      assert match?(
               {:error, %Telnyx.Error{}},
               Telnyx.Messages.create_long_code(@invalid_params, @test_key)
             )
    end

    # Not implemented yet in testing server
    # test "succeeds with valid params" do
    #   assert match?(
    #            {:ok, %{"text" => _}},
    #            Telnyx.Messages.create_long_code(@valid_params, @test_key)
    #          )
    # end
  end

  describe "create_from_number_pool/2" do
    test "fails without required params" do
      assert match?(
               {:error, %Telnyx.Error{}},
               Telnyx.Messages.create_from_number_pool(@invalid_params, @test_key)
             )
    end

    # Not implemented yet in testing server
    # test "succeeds with valid params" do
    #   params =
    #     @valid_params
    #     |> Map.drop([:from])
    #     |> Map.put(:messaging_profile_id, "uuid")

    #   assert match?(
    #            {:ok, %{"text" => _}},
    #            Telnyx.Messages.create_from_number_pool(params, @test_key)
    #          )
    # end
  end

  describe "create_short_code/2" do
    test "fails without required params" do
      assert match?(
               {:error, %Telnyx.Error{}},
               Telnyx.Messages.create_short_code(@invalid_params, @test_key)
             )
    end

    # Not implemented yet in testing server
    # test "succeeds with valid params" do
    #   params =
    #     @valid_params
    #     |> Map.put(:from, "12345")

    #   assert match?(
    #            {:ok, %{"text" => _}},
    #            Telnyx.Messages.create_short_code(params, @test_key)
    #          )
    # end
  end

  describe "retrieve/2" do
    test "fails without a uuid" do
      refute match?({:ok, _}, Telnyx.Messages.retrieve(nil, @test_key))
      refute match?({:ok, _}, Telnyx.Messages.retrieve("", @test_key))
    end

    test "succeeds with valid uid" do
      assert match?({:ok, _}, Telnyx.Messages.retrieve(@uuid, @test_key))
    end
  end
end
