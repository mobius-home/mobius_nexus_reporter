# MobiusNexusReporter

A Mobius remote reporter for the [Nexus](https://github.com/mobius-home/nexus)
server

This requires your project to use `:mobius` version `0.5.1` or greater.

## Install

```elixir
def deps() do
  [
    {:mobius_nexus_reporter, "~> 1.2"}
  ]
end
```

## Configuration with Mobius

When configuring Mobius you can provide the `:remote_reporter` configuration
with the following config:

```elixir
def start(_type, _args) do
  metrics = [
    Metrics.last_value("my.telemetry.event"),
  ]

  children = [
    # ... other children ....
    {Mobius,
      metrics: metrics,
      remote_reporter:
        {MobiusNexusReporter,
          token: "thetoken", host: "https://mynexusserver.com"},
      remote_report_interval: 60_000}
    # ... other children ....
  ]

  opts = [strategy: :one_for_one, name: MyApp.Supervisor]
  Supervisor.start_link(children, opts)
end
```
