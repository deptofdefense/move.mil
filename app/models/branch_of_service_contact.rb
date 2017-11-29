class BranchOfServiceContact < ApplicationRecord
  belongs_to :branch_of_service

  def retiree_contact_phone?
    retiree_dsn || retiree_tel_comm || retiree_tel_tollfree
  end

  def retiree_contact_fax?
    retiree_fax_dsn || retiree_fax_comm || retiree_fax_tollfree
  end

  def retiree_contact_info?
    retiree_contact_phone? || retiree_contact_fax? || retiree_email || retiree_post
  end

  def customer_service_contact_info?
    custsvc_dsn? || custsvc_tel_comm? || custsvc_tel_tollfree? || custsvc_email? || custsvc_url? || custsvc_facebook_url
  end

  def claims_contact_info?
    claims_dsn? || claims_tel_comm? || claims_tel_tollfree? || claims_fax_dsn? || claims_fax_comm? || claims_fax_tollfree? || claims_email? || claims_post?
  end
end
