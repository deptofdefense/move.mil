# rubocop:disable Lint/PercentStringArray
SecureHeaders::Configuration.default do |config|
  config.csp = {
    base_uri: %w['self'],
    block_all_mixed_content: true,
    child_src: %w[www.youtube.com],
    default_src: %w['self'],
    form_action: %w['self'],
    frame_ancestors: %w['none'],
    img_src: %w['self' data: www.google-analytics.com *.tile.openstreetmap.org],
    plugin_types: %w[application/x-shockwave-flash],
    script_src: %w['self' 'unsafe-inline' dap.digitalgov.gov www.google-analytics.com],
    style_src: %w['self' 'unsafe-inline']
  }

  config.hsts = 'max-age=15768000'
  config.referrer_policy = %w[origin-when-cross-origin strict-origin-when-cross-origin]
  config.x_content_type_options = 'nosniff'
  config.x_download_options = 'noopen'
  config.x_frame_options = 'deny'
  config.x_permitted_cross_domain_policies = 'none'
  config.x_xss_protection = '1; mode=block'
end
# rubocop:enable Lint/PercentStringArray
