class BranchOfServiceContact < ApplicationRecord
  validates :branch, presence: true

  def retiree_contact_phone?
    retiree_dsn || retiree_tel_comm || retiree_tel_tollfree
  end

  def retiree_contact_fax?
    retiree_fax_dsn || retiree_fax_comm || retiree_fax_tollfree
  end

  def retiree_contact_info?
    retiree_contact_phone? || retiree_contact_fax? || retiree_email || retiree_post
  end
end
