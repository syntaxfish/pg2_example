defmodule EchoClient.Client do
  use GenServer

  @init_state %{}

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: EchoClient.Client)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  ## Public API
  def send_echo(pid, message) do
    GenServer.call(pid, {:send_echo, message})
  end

  ## Callback API
  def handle_call({:send_echo, message}, _from, state) do
    case :pg2.get_closest_pid(:echo_server) do
      pid when is_pid(pid) ->
        echo = GenServer.call(pid, {:echo, message})
        {:reply, echo, state}
      {:error, _r} = error ->
        {:reply, error, state}
    end
  end
end
