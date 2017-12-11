json.name t('site.name')
json.short_name t('site.name')
json.start_url '/'

json.icons %w[192x192 512x512] do |sizes|
  json.src asset_path("meta/android-chrome-#{sizes}.png")
  json.sizes sizes
  json.type 'image/png'
end

json.display 'standalone'
json.background_color '#d6d7d9'
json.theme_color '#d6d7d9'
json.lang I18n.locale
