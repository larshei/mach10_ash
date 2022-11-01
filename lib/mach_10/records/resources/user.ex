defmodule Mach10.Records.User do
  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshJsonApi.Resource]

  postgres do
    table "users"
    repo Mach10.Repo
  end

  # multitenancy do
  #   strategy :attribute
  #   attribute :organization_id
  # end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  relationships do
    belongs_to :organization, Mach10.Records.Organization
    has_many :records, Mach10.Records.Record
    has_many :history, Mach10.Records.History
  end

  attributes do
    integer_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end

    attribute :reference, :string do
      allow_nil? false
      always_select? true

      description "Externally set ID so that external systems can use their own IDs instead of having to store ours."
    end

    attribute :avatar_url, :string do
      description "An image that is displayed on some occasions. Preferred resolution is <TODO>"
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  json_api do
    type "user"

    routes do
      base "/users"

      get :read
      index :read
      post :create
      patch :update
      delete :destroy
    end
  end
end
