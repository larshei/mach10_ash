defmodule Mach10Web.AshResourceRouter do
  use AshJsonApi.Api.Router, api: Mach10.Records, registry: Mach10.Records.Registry
end
