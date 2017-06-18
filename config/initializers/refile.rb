if Rails.env.production?
  require 'refile/backend/s3'

  aws = {
    access_key_id: Rails.application.secrets.s3_key,
    secret_access_key:  Rails.application.secrets.s3_secret,
    bucket: Rails.application.secrets.s3_bucket
  }

  Refile.cache = Refile::Backend::S3.new(prefix: 'cache', **aws)
  Refile.store = Refile::Backend::S3.new(prefix: 'store', **aws)
end
