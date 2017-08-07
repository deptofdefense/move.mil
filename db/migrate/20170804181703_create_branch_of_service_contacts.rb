class CreateBranchOfServiceContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_of_service_contacts do |t|
      t.text :branch
      t.text :custsvc_org
      t.text :custsvc_dsn
      t.text :custsvc_tel_comm
      t.text :custsvc_tel_tollfree
      t.text :custsvc_email
      t.text :custsvc_hours
      t.text :custsvc_url
      t.text :custsvc_facebook_url
      t.text :claims_dsn
      t.text :claims_tel_comm
      t.text :claims_tel_tollfree
      t.text :claims_fax_dsn
      t.text :claims_fax_comm
      t.text :claims_fax_tollfree
      t.text :claims_email
      t.text :claims_post
      t.text :retiree_dsn
      t.text :retiree_tel_comm
      t.text :retiree_tel_tollfree
      t.text :retiree_fax_dsn
      t.text :retiree_fax_comm
      t.text :retiree_fax_tollfree
      t.text :retiree_email
      t.text :retiree_post

      t.timestamps
    end
  end
end
