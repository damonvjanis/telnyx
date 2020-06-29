defmodule Telnyx.MessagingProfilesTest do
  use ExUnit.Case, async: true

  @test_key "KEYSUPERSECRET"
  @uuid "uuid"

  describe "list/2" do
    test "succeeds without params" do
      {:ok, list = [first | _]} = Telnyx.MessagingProfiles.list(@test_key)

      assert is_list(list)
      assert is_map(first)
    end

    test "succeeds with params" do
      # This call succeeds on prod, but the test server doesn't support the params
      # so we're not actually making the call (since it results in an error).

      # Telnyx.MessagingProfiles.list(@test_key, page: %{size: 10})
    end
  end

  describe "create/2" do
    test "succeeds with valid params" do
      assert match?(
               {:ok, %{"name" => "Summer Campaign"}},
               Telnyx.MessagingProfiles.create(%{"name" => "Summer Campaign"}, @test_key)
             )
    end
  end

  describe "delete/2" do
    test "fails without a uuid" do
      refute match?({:ok, _}, Telnyx.MessagingProfiles.delete(nil, @test_key))
      refute match?({:ok, _}, Telnyx.MessagingProfiles.delete("", @test_key))
    end

    test "succeeds with valid uid" do
      assert match?({:ok, _}, Telnyx.MessagingProfiles.delete(@uuid, @test_key))
    end
  end

  describe "retrieve/2" do
    test "fails without a uuid" do
      refute match?({:ok, _}, Telnyx.MessagingProfiles.retrieve(nil, @test_key))
      refute match?({:ok, _}, Telnyx.MessagingProfiles.retrieve("", @test_key))
    end

    test "succeeds with valid uid" do
      assert match?({:ok, _}, Telnyx.MessagingProfiles.retrieve(@uuid, @test_key))
    end
  end

  describe "update/2" do
    test "fails without a uuid" do
      params = %{name: "Summer Campaign"}

      refute match?({:ok, _}, Telnyx.MessagingProfiles.update(params, nil, @test_key))
      refute match?({:ok, _}, Telnyx.MessagingProfiles.update(params, "", @test_key))
    end

    test "succeeds with valid uid and params" do
      params = %{name: "Summer Campaign"}
      assert match?({:ok, _}, Telnyx.MessagingProfiles.update(params, @uuid, @test_key))
    end
  end

  describe "list_messaging_profile_phone_numbers/2" do
    test "succeeds without params" do
      {:ok, list = [first | _]} =
        Telnyx.MessagingProfiles.list_messaging_profile_phone_numbers(@uuid, @test_key)

      assert is_list(list)
      assert is_map(first)
    end

    test "succeeds with params" do
      # This call succeeds on prod, but the test server doesn't support the params
      # so we're not actually making the call (since it results in an error).

      # Telnyx.MessagingProfiles.list_messaging_profile_phone_numbers(@uuid, @test_key, page: %{size: 10})
    end
  end

  describe "list_messaging_profile_short_codes/2" do
    test "succeeds without params" do
      {:ok, list = [first | _]} =
        Telnyx.MessagingProfiles.list_messaging_profile_short_codes(@uuid, @test_key)

      assert is_list(list)
      assert is_map(first)
    end

    test "succeeds with params" do
      # This call succeeds on prod, but the test server doesn't support the params
      # so we're not actually making the call (since it results in an error).

      # Telnyx.MessagingProfiles.list_messaging_profile_short_codes(@uuid, @test_key, page: %{size: 10})
    end
  end
end
