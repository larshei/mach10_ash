defmodule Mach10.Records.Registry do
  use Ash.Registry,     extensions: [
    # This extension adds helpful compile time validations
    Ash.Registry.ResourceValidations
  ]

  entries do
    entry Mach10.Records.Organization
    entry Mach10.Records.Record
    entry Mach10.Records.Track
    entry Mach10.Records.User
    entry Mach10.Records.History
  end


end
