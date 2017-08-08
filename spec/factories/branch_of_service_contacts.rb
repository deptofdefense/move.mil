FactoryGirl.define do
  sequence(:branch) { |n| "Branch #{n}" }

  factory :branch_of_service_contact do
    branch
    custsvc_org 'My org'
    custsvc_dsn '555-1234'
    custsvc_tel_comm '(555)-555-9999'
    custsvc_tel_tollfree '1-800-555-0123'
    custsvc_email 'custsvc@example.com'
    custsvc_hours '0800-1700 est M-F'
    custsvc_url 'http://custsvc.example.com'
    custsvc_facebook_url 'https://www.facebook.com/custsvc'
    claims_dsn '555-9876'
    claims_tel_comm '(555)-555-8765'
    claims_tel_tollfree '1-800-555-5555'
    claims_fax_dsn '555-4444'
    claims_fax_comm '(555)-555-4444'
    claims_fax_tollfree '1-800-555-4444'
    claims_email 'claims@example.com'
    claims_post ''
    retiree_dsn '555-7777'
    retiree_tel_comm '(555)-555-7777'
    retiree_tel_tollfree '1-800-555-7777'
    retiree_fax_dsn '555-6666'
    retiree_fax_comm '(555)-555-6666'
    retiree_fax_tollfree '1-800-555-6666'
    retiree_email 'ret1@example.com,ret2@example.com'
    retiree_post ''
  end
end
