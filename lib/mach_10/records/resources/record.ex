defmodule Mach10.Records.Record do
  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshJsonApi.Resource]

  postgres do
    table "records"
    repo Mach10.Repo
  end

  # multitenancy do
  #   strategy :attribute
  #   attribute :organization_id
  # end

  code_interface do
    define_for Mach10.Records

    define :for_track, args: [:track_id]
    define :for_user, args: [:user_id]
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:time_ms]

      argument :track_id, :integer
      argument :user_id, :integer

      change manage_relationship(:track_id, :track, type: :append_and_remove)
      change manage_relationship(:user_id, :user, type: :append_and_remove)
    end

    read :for_track do
      argument :track_id, :integer do
        allow_nil? false
      end

      filter expr(track_id == ^arg(:track_id))
    end

    read :for_user do
      argument :user_id, :integer do
        allow_nil? false
      end

      filter expr(user_id == ^arg(:user_id))
    end

    read :for_track_and_user do
      argument :user_id, :integer do
        allow_nil? false
      end
      argument :track_id, :integer do
        allow_nil? false
      end

      filter expr(user_id == ^arg(:user_id) and track_id == ^arg(:track_id))
    end
  end

  relationships do
    # belongs_to :organization, Mach10.Records.Organization
    belongs_to :track, Mach10.Records.Track do
      allow_nil? false
      primary_key? true
      attribute_type :integer
    end
    belongs_to :user, Mach10.Records.User do
      allow_nil? false
      primary_key? true
      attribute_type :integer
    end
  end

  attributes do
    attribute :time_ms, :integer do
      allow_nil? false
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  json_api do
    type "record"

    # Ash requires a single primary key in order to create an API.
    # We are composing the primary key here, so we need to give Ash a way
    # to merge them to a single key/id.
    primary_key do
      keys [:track_id, :user_id]
      delimiter ":"
    end

    routes do
      base "/records"

      post :create
      index :for_track, route: "/track/:track_id"
      index :for_user, route: "/user/:user_id"
      index :for_track_and_user, route: "/track/:track_id/user/:user_id"
    end
  end
end
