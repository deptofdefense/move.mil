module FeedbackMailerHelper
  # rubocop:disable Metrics/AbcSize
  def typeset(str, max_length = 80)
    grafs = str.squeeze(' ').split(/[\r?\n]+/)

    grafs.each_with_index do |graf, index|
      words = graf.strip.split(' ')
      slugs = ['']

      words.each do |word|
        slug = slugs.last
        target = slug.length + word.length > max_length ? slugs : slug

        target << "#{word} "
      end

      grafs[index] = slugs.join("\n")
    end

    grafs.join("\n\n")
  end
  # rubocop:enable Metrics/AbcSize
end
