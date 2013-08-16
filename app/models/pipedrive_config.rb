class PipedriveConfig < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :key, :value, :user_id

  KEYS = { app_key: "APP_KEY", org_id: "ORG_ID" }

  def self.find_app_key_by_user(user)
    find(key: KEYS[:app_key], user_id: user.id).value
  end

  def self.create_organization(person, app_key)
    org = Pipedrive::Organization.new(app_key)
    org_response = org.create({ name: person.company })

    PipedriveConfig.create(
      key: KEYS[:org_id], 
      value: org.id_from_response(org_response), 
      user_id: person.user_id)
  end
end