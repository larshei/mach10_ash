defmodule Mach10.Records.History do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    table "history"
    repo Mach10.Repo
  end

  # multitenancy do
  #   strategy :attribute
  #   attribute :organization_id
  # end

  actions do
    defaults [:create, :read]
  end

  relationships do
    # belongs_to :organization, Mach10.Records.Organization
    belongs_to :track, Mach10.Records.Track do
      attribute_type :integer
    end
    belongs_to :user, Mach10.Records.User do
      attribute_type :integer
    end
  end

  attributes do
    integer_primary_key :id

    attribute :time_ms, :integer do
      allow_nil? false
    end

    create_timestamp :inserted_at
  end
end
