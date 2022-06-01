defmodule MobiusNexusReporter do
  @moduledoc """
  Documentation for `MobiusNexusReporter`.
  """

  @behaviour Mobius.RemoteReporter

  alias Mobius.Exports.MobiusBinaryFormat

  @typedoc """
  Arguments to the nexus reporter

  * `:token` - the API token for the nexus server (required)
  * `:host` - the host name for the nexus server (required)
  """
  @type arg() :: {:token, binary()} | {:host, binary()}

  @typep state() :: %{token: binary(), host: binary()}

  @impl Mobius.RemoteReporter
  @spec init([arg()]) :: {:ok, state()}
  def init(args) do
    token = Keyword.fetch!(args, :token)
    host = Keyword.fetch!(args, :host)

    {:ok, %{token: token, host: host}}
  end

  @impl Mobius.RemoteReporter
  def handle_metrics(metrics, state) do
    url = "#{state.host}/api/v1/products/smartrent-hub/devices/SRH123/metrics"
    iodata = MobiusBinaryFormat.to_iodata(metrics)

    bin_list =
      iodata
      |> IO.iodata_to_binary()
      |> :erlang.binary_to_list()

    Req.post!(url, Jason.encode!(%{metrics: bin_list}),
      headers: [{"Content-type", "application/json"}, {"Authorization", "Bearer #{state.token}"}]
    )

    {:noreply, state}
  end
end
