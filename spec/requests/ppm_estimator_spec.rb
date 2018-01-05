RSpec.describe PpmEstimatorController, type: :request do
  describe 'GET #index' do
    let!(:e1) { create(:entitlement, rank: 'E-1', total_weight_self: 5_000, total_weight_self_plus_dependents: 8_000, pro_gear_weight: 2_000, pro_gear_weight_spouse: 500) }
    let!(:o6) { create(:entitlement, rank: 'O-6', total_weight_self: 18_000, total_weight_self_plus_dependents: 18_000, pro_gear_weight: 2_000, pro_gear_weight_spouse: 500) }

    let!(:army) { create(:branch_of_service, name: 'Army') }
    let!(:marine_corps) { create(:branch_of_service, name: 'Marine Corps') }

    context 'when navigating to the page' do
      before do
        get '/resources/ppm-estimator'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end

      it 'populates the rank select input' do
        # count includes the blank or prompt option
        assert_select '#rank option', count: 3
      end

      it 'populates the branch select input' do
        # count includes the blank or prompt option
        assert_select '#branch option', count: 3
      end
    end

    context 'when calculating a PPM estimate' do
      let!(:la_dc_1000lbs_linehaul) { create(:conus_linehaul) }
      let!(:la_dc_distance) { create(:dtod_zip3_distance) }

      let!(:la_zip3) { create(:zip3) }
      let!(:dc_zip3) { create(:zip3, zip3: 200, basepoint_city: 'Washington', state: 'DC', service_area: 169, rate_area: '24', region: 10) }

      let!(:la_svc_area) { create(:service_area) }
      let!(:dc_svc_area) { create(:service_area, service_area: 169, name: 'Washington, DC Metro', services_schedule: 3, linehaul_factor: 2.23, orig_dest_service_charge: 9.82, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-15'))) }

      let!(:full_pack_sch_3) { create(:full_pack) }
      let!(:full_unpack_sch_3) { create(:full_unpack) }

      let!(:top_discount_la_dc) { create(:top_tsp_by_channel_linehaul_discount) }

      context 'and sending valid params' do
        before do
          get '/resources/ppm-estimator', params: { rank: 'e-1', branch: 'army', dependents: 'yes', start: '90210', end: '20001', date_year: '2018', date_month: '1', date_day: '31', weight: '1000' }, xhr: true
        end

        it 'shows a PPM estimate' do
          assert_select '.ppm-estimate-amount-total', count: 2
        end
      end

      context 'less than 800 miles' do
        let!(:shorthaul_1000) { create(:shorthaul) }
        let!(:lv_zip3) { create(:zip3, zip3: 889, basepoint_city: 'Las Vegas', state: 'NV', service_area: 500, rate_area: '86', region: 2) }
        let!(:lv_svc_area) { create(:service_area, service_area: 500, name: 'Las Vegas, NV', services_schedule: 3, linehaul_factor: 0.61, orig_dest_service_charge: 3.63, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))) }
        let!(:la_lv_dtod) { create(:dtod_zip3_distance, orig_zip3: 902, dest_zip3: 889, dist_mi: 281.4) }
        let!(:la_lv_1000lbs_linehaul) { create(:conus_linehaul, dist_mi: Range.new(251, 300), weight_lbs: Range.new(1000, 1099), rate: 1722, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))) }
        let!(:la_lv_top_discount) { create(:top_tsp_by_channel_linehaul_discount, orig: 'US88', dest: 'REGION 2', tdl: Range.new(Date.parse('2017-10-01'), Date.parse('2017-12-31')), discount: 67.0) }

        before do
          get '/resources/ppm-estimator', params: { rank: 'e-1', branch: 'army', dependents: 'yes', start: '90210', end: '88901', date_year: '2018', date_month: '1', date_day: '31', weight: '1000' }, xhr: true
        end

        it 'shows a PPM estimate' do
          assert_select '.ppm-estimate-amount-total', count: 2
        end
      end

      context 'with a location in a service area that requires a full ZIP5 lookup' do
        let!(:ocala_zip3) { create(:zip3, zip3: 344, basepoint_city: 'Dunnellon', state: 'FL', service_area: 176, rate_area: 'ZIP', region: 13) }
        let!(:ocala_zip5_rate_area) { create(:zip5_rate_area) }
        let!(:ocala_service_area) { create(:service_area, service_area: 176, name: 'Jacksonville, FL', services_schedule: 2, linehaul_factor: 0.4, orig_dest_service_charge: 4.13, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))) }
        let!(:ocala_full_pack) { create(:full_pack, schedule: 2, weight_lbs: Range.new(0, 16_000), rate: 60.05, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))) }
        let!(:ocala_dc_dtod) { create(:dtod_zip3_distance, orig_zip3: 344, dest_zip3: 200, dist_mi: 817.8) }
        let!(:ocala_dc_1000lbs_linehaul) { create(:conus_linehaul, dist_mi: Range.new(801, 850), weight_lbs: Range.new(1000, 1099), rate: 2113, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))) }
        let!(:ocala_dc_top_discount) { create(:top_tsp_by_channel_linehaul_discount, orig: 'US49', dest: 'REGION 10', tdl: Range.new(Date.parse('2017-10-01'), Date.parse('2017-12-31')), discount: 67.0) }

        before do
          get '/resources/ppm-estimator', params: { rank: 'e-1', branch: 'army', dependents: 'yes', start: '34470', end: '20001', date_year: '2018', date_month: '1', date_day: '31', weight: '1000' }, xhr: true
        end

        it 'shows a PPM estimate' do
          assert_select '.ppm-estimate-amount-total', count: 2
        end
      end

      context 'and a required parameter is missing' do
        [:rank, :branch, :dependents, :start, :end, :date, :weight].each do |param|
          let(:required_params) { { rank: 'e-1', branch: 'army', dependents: 'yes', start: '90210', end: '20001', date: '2017-12-31', weight: '1000' } }
          before do
            missing_a_param = required_params.deep_dup
            missing_a_param.delete(param)
            get '/resources/ppm-estimator', params: :missing_a_param, xhr: true
          end

          it 'returns HTTP not found status code' do
            expect(response).to have_http_status(:not_found)
          end
        end
      end

      context 'and sending an invalid date' do
        let(:bad_date_params) { { rank: 'e-1', branch: 'army', dependents: 'yes', start: '90210', end: '20001', date: '2017-02-31', weight: '1000' } }

        before do
          get '/resources/ppm-estimator', params: :bad_date_params, xhr: true
        end

        it 'returns HTTP not found status code' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
