class BranchOfServiceContact < ApplicationRecord
  validates :branch, presence: true

  def retiree_contact_info?
    retiree_dsn || 
    retiree_tel_comm || 
    retiree_tel_tollfree || 
    retiree_email || 
    retiree_fax_dsn || 
    retiree_fax_comm || 
    retiree_fax_tollfree || 
    retiree_post
  end
end
