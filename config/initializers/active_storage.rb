ActiveSupport.on_load(:active_storage_attachment) do
  class ActiveStorage::Attachment < ActiveStorage::Record
    Rails.application.config.active_storage.resolve_model_to_route = :rails_storage
    ActiveStorage::Current.url_options = Rails.application.config.action_mailer.default_url_options
    def self.ransackable_attributes(auth_object = nil)
      %w[blob_id created_at id name record_id record_type]
    end
  end
end
