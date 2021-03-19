require Rails.root.join("config", "environments", "production")

Rails.application.configure do
  # Settings specified here will take precedence over those in config/environments/production.rb.

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true
end
