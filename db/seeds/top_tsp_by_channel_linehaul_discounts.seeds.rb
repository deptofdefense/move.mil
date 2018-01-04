require 'csv'

module Seeds
  class TopTspByChannelLinehaulDiscounts
    def seed!
      return puts '', 'Cannot load encrypted discounts file! Ensure that both the SEEDS_ENC_IV and SEEDS_ENC_KEY environment variables are properly set.' unless self.class.configured?

      cipher.decrypt
      cipher.iv = [ENV['SEEDS_ENC_IV']].pack('H*')
      cipher.key = [ENV['SEEDS_ENC_KEY']].pack('H*')

      discount_files.each do |path, year, tdl|
        discounts_csv = cipher.update(File.read(path))
        discounts_csv << cipher.final

        # after each discounts file, reset the cipher to read more files
        cipher.reset

        discounts = CSV.parse(discounts_csv, headers: true)

        discounts.each do |row|
          TopTspByChannelLinehaulDiscount.where(orig: row['ORIGIN'], dest: row['DESTINATION'], tdl: dates_by_tdl[tdl]).first_or_initialize.tap do |d|
            d.discount = row['LH_RATE']
            d.save
          end
        end
      end
    end

    def self.configured?
      ENV['SEEDS_ENC_IV'].present? && ENV['SEEDS_ENC_KEY'].present?
    end

    private

    def cipher
      @cipher ||= OpenSSL::Cipher::AES256.new(:CBC)
    end

    # date ranges for when the BVS scores from specific performance periods take effect
    def dates_by_tdl
      @dates_by_tdl ||= [
        Range.new(Date.new(year, 5, 15), Date.new(year, 7, 31)),
        Range.new(Date.new(year, 8, 1), Date.new(year, 9, 30)),
        Range.new(Date.new(year, 10, 1), Date.new(year, 12, 31)),
        Range.new(Date.new(year + 1, 1, 1), Date.new(year + 1, 3, 6)),
        Range.new(Date.new(year + 1, 3, 7), Date.new(year + 1, 5, 14))
      ]
    end

    # path, year, and tdl. Remember that rates take effect May 15, so the two
    # TDLs before that date belong to the previous year
    def discount_files
      @discount_files ||= [
        [Rails.root.join('lib', 'data', 'No 1 BVS Dom Discounts - Eff 1Oct2017.csv.enc'), 2017, 2],
        [Rails.root.join('lib', 'data', 'No 1 BVS Dom Discounts - Eff 1Jan2018.csv.enc'), 2017, 3]
      ]
    end
  end
end
