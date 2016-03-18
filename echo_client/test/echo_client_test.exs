defmodule EchoClientTest do
  use ExUnit.Case

  alias EchoClient.Client

  test "no such group" do
    echo = Client.send_echo(Client, "hhi")

    assert echo == {:error, {:no_such_group, :echo_server}}
  end
end
