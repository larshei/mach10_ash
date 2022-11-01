defmodule Mach10.Records do
  use Ash.Api, extensions: [AshJsonApi.Api]

  json_api do
    prefix "/api"
    serve_schema? true
    log_errors? true
  end

  resources do
    registry Mach10.Records.Registry
  end
end
