defmodule EchoServer.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: EchoServer.Server)
  end

  def init(:ok) do
    :pg2.create(:echo_server)
    :pg2.join(:echo_server, self)

    {:ok, %{}}
  end

  ## Public API
  def echo(pid, message) do
    GenServer.call(pid, {:echo, message})
  end

  ## Callback API
  def handle_call({:echo, message}, _from, state) do
    {:reply, build_echo_message(message), state}
  end

  def build_echo_message(message) do
    "[#{Node.self |> to_string}] #{message}"
  end
end
