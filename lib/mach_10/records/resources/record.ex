defmodule Mach10.Records.Record do
  use Ash.Resource

  # postgres do
  #   table "records"
  #   repo Mach10.Repo
  # end

  multitenancy do
    strategy :attribute
    attribute :organization_id
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  relationships do
    belongs_to :organization, Mach10.Records.Organization
    belongs_to :track, Mach10.Records.Track do
      allow_nil? false
      primary_key? true
    end
    belongs_to :user, Mach10.Records.User do
      allow_nil? false
      primary_key? true
    end
  end

  attributes do
    attribute :time_ms, :integer do
      allow_nil? false
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end
end
