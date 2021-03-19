Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  if config.x.dockerized
    config.x.datadog.host = "datadog.kube-system"
    config.x.datadog_trace.host = "datadog-trace.kube-system"
  end

    # Use lograge gem for logging in JSON
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Raw.new

    # Add the request parameters to the log, as well as the time
    config.lograge.custom_options = lambda do |event|
      exceptions = %w(controller action format id)
      {
        # event.time isn't always a Time, it starts a Float.
        time: event.time.respond_to?(:strftime) ? event.time.strftime("%Y-%m-%d %H:%M:%S.%9N %z") : event.time,
        params: event.payload[:params].except(*exceptions)
      }
    end
    config.lograge.custom_payload do |controller|
      request = controller.request
      {
        ip: request.remote_ip,
        request_id: request.request_id,
        service: request.ezcater_service_name
      }.compact
    end

    # Ensure logs are in JSON format
    config.log_formatter = lambda do |severity, timestamp, progname, msg|
      data = {
        severity: severity,
        time: timestamp.strftime("%Y-%m-%d %H:%M:%S.%9N %z"),
        progname: progname
      }.compact
      case msg
      when Hash
        data.reverse_merge!(msg)
      else
        data[:msg] = msg
      end
      JSON.dump(data) + "\n"
    end

    log_path = config.x.dockerized ? "/proc/1/fd/1" : Rails.root.join("log", "#{Rails.env}.log")
    config.logger = ActiveSupport::Logger.new(log_path)
    config.logger.formatter = config.log_formatter

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = true

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.action_controller.asset_host = 'https://static.cdn-ezcater.com'
  config.assets.prefix = "/matchmaker"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  # config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Include ActionDispatch::SSL middleware, but only enable secure cookies.
  config.force_ssl = true
  config.ssl_options = {
    redirect: false,
    hsts: false,
    secure_cookies: true,
  }

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = ENV.fetch("LOG_LEVEL", :info).to_sym

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "matchmaker_rails_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Inserts middleware to perform automatic connection switching.
  # The `database_selector` hash is used to pass options to the DatabaseSelector
  # middleware. The `delay` is used to determine how long to wait after a write
  # to send a subsequent read to the primary.
  #
  # The `database_resolver` class is used by the middleware to determine which
  # database is appropriate to use based on the time delay.
  #
  # The `database_resolver_context` class is used by the middleware to set
  # timestamps for the last write to the primary. The resolver uses the context
  # class timestamps to determine how long to wait before reading from the
  # replica.
  #
  # By default Rails will store a last write timestamp in the session. The
  # DatabaseSelector middleware is designed as such you can define your own
  # strategy for connection switching and pass that into the middleware through
  # these configuration options.
  # config.active_record.database_selector = { delay: 2.seconds }
  # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
end
