class PipedriveConfig < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :key, :value, :user_id

  KEYS = { 
    app_key: "APP_KEY", 
    org_id: "ORG_ID", 
    custom_field_job: "CUSTOM_FIELD_JOB",
    custom_field_website: "CUSTOM_FIELD_WEBSITE" }
  CUSTOM_FIELDS_TITLE = { job: "Job Title", website: "Website" }


  def self.find_app_key_by_user(user)
    pipedrive_config = where(key: KEYS[:app_key], user_id: user.id).first
    pipedrive_config.value unless pipedrive_config.blank?
  end

  def self.find_or_initialize_app_key(value, user)
    paramas = { user_id: user.id, key: KEYS[:app_key] }

    pipedrive_config = PipedriveConfig.where(paramas).first || PipedriveConfig.new(paramas)
    
    pipedrive_config.value = value
    pipedrive_config
  end

  def self.generate_custom_fields(user, app_key)
    # job
    generate_custom_field(user, app_key, CUSTOM_FIELDS_TITLE[:job], KEYS[:custom_field_job])

    # website
    generate_custom_field(user, app_key, CUSTOM_FIELDS_TITLE[:website], KEYS[:custom_field_website])
  end

  def self.generate_custom_field(user, app_key, label_name, field_key)
    custom_field = Pipedrive::PersonField.new(app_key)

    field_response = custom_field.create({ name: label_name, field_type: "varchar" })
    field_id = custom_field.id_from_response(field_response)

    field = custom_field.find(field_id)

    create(
      key: field_key, 
      value: custom_field.key_from_response(field), 
      user_id: user.id)
  end

  def self.import_person_to_pipedrive(person, app_key)
    org = create_organization(person, app_key)
    job_field_key = where(key: KEYS[:custom_field_job], user_id: person.user_id).first.value
    website_field_key = where(key: KEYS[:custom_field_website], user_id: person.user_id).first.value

    person_to_import = {
      name: person.name,
      org_id: org.value,
      email: [person.email],
      phone: [person.phone],
      job_field_key => person.job_title,
      website_field_key => person.website
    }

    Pipedrive::Person.new(app_key).create(person_to_import)
  end

  def self.create_organization(person, app_key)
    org = Pipedrive::Organization.new(app_key)
    org_response = org.create({ name: person.company })

    create(
      key: KEYS[:org_id], 
      value: org.id_from_response(org_response), 
      user_id: person.user_id)
  end
end