class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include SetSource
  include CurrentUserConcern
  include DefaultPageContent

  # :alert and :notice are included by rails
  add_flash_types :error, :warning, :success
end

