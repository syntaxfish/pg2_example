defmodule EchoClient do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(EchoClient.Client, []),
    ]

    opts = [strategy: :one_for_one, name: EchoClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
