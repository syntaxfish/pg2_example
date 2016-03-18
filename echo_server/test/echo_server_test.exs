defmodule EchoServerTest do
  use ExUnit.Case

  alias EchoServer.Server

  @message "hi!!"

  test "process call by local name" do
    echo = Server.echo(Server, @message)

    assert echo == Server.build_echo_message(@message)
  end


  test "proces call by pg2" do
    echo = :pg2.get_closest_pid(:echo_server)
    |> GenServer.call({:echo, @message})

    assert echo == Server.build_echo_message(@message)
  end
end
