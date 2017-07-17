module ApplicationHelper
  def abbr_tag(i18n_key, options = {})
    tag_options = {
      title: t("abbrs.#{i18n_key}")
    }.merge(options)

    tag.abbr i18n_key.upcase, tag_options
  end
end
