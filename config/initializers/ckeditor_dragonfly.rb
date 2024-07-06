# frozen_string_literal: true

# Load Dragonfly if it isn't loaded already.
require 'dragonfly'

Dragonfly.app(:ckeditor).configure do
  plugin :imagemagick
  secret "8174dc5682b259d14ed1c5604d151550377e102b535e7fa5b0486de6e111a245"

  # Store files in public/uploads/ckeditor. This is not
  # mandatory and the files don't even have to be stored under
  # public. See http://markevans.github.io/dragonfly/data-stores
  datastore :file, root_path: Rails.root.join('public/uploads/ckeditor', Rails.env).to_s,
                   server_root: 'public'

  # Accept asset requests on /ckeditor_assets. Again, this path is
  # not mandatory. Just be sure to include :job somewhere.
  url_format '/uploads/ckeditor/:job/:basename.:format'
end

Rails.application.middleware.use Dragonfly::Middleware, :ckeditor
