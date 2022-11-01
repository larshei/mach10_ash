defmodule Mach10.Records.Organization do
  use Ash.Resource

  # postgres do
  #   table "organizations"
  #   repo Mach10.Repo
  # end

  relationships do
    has_many :records, Mach10.Records.Record
    has_many :users, Mach10.Records.Record
    has_many :tracks, Mach10.Records.Record
  end

  attributes do
    attribute :id, :string do
      description "Identifies the Organization. The organization ID is also used by the API as the subdomain. Example: 'redout' would be become redout.mach10.io/..."
      allow_nil? false
      primary_key? true
    end

    attribute :name, :string do
      description "Display name of the Organization"
      allow_nil? false
    end

    attribute :logo_url, :string do
      description "Small Logo used for headers. Preferred resolution is <TODO>"
    end

    attribute :header_img_url, :string do
      description "An image that is used to present your organization/game/... on the title pages. Preferred resolution is <TODO>"
    end

    attribute :description, :string do
      description "Description for your organization. Supports markdown."
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end
end
