RSpec.describe PpmEstimatorController, type: :request do
  describe 'GET #index' do
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
      end

      it 'populates the branch select input' do
      end
    end

    context 'when calculating a PPM estimate' do
      context 'and a required parameter is missing' do
        [:rank, :branch, :dependents, :start, :end, :date, :weight].each do |param|
          let (:required_params) { { rank: 'e-1', branch: 'army', dependents: 'yes', start: '90210', end: '20001', date: '2017-12-31', weight: '1000' } }
          before do
            missing_a_param = required_params.deep_dup
            missing_a_param.delete(param)
            get '/resources/ppm-estimator', params: :missing_a_param, xhr: true
          end

          it 'returns HTTP redirect status code' do
            expect(response).to have_http_status(:not_found)
          end
        end
      end

      context 'when sending valid params' do
      end

      context 'when sending a date earlier than the earliest filed performance period' do
        it 'matches the results of the same calculation with a date within the earliest performance period' do
        end
      end

      context 'when sending a date later than the last filed performance period' do
        it 'matches the results of the same calculation with a date within the latest performance period' do
        end
      end

      context 'when entering an invalid start ZIP code' do
        # it 'displays an error message' do
        #   get '/resources/ppm-estimator', params: { rank: 'e-5', branch: 'army', dependents: 'yes', married: 'yes', start: '00100', end: '90210', date: Date.today.to_s, weight: '1000', selfpack: 'yes' }
        #   assert_select '#ppm-estimate-alert[hidden]', count: 0
        # end
      end

      context 'when entering an invalid end ZIP code' do
      end

      context 'when entering an invalid date' do
      end

      context 'when exceeding weight entitlement' do
        it 'highlights the weight text input' do
        end

        it 'estimates the incentive with the total weight limited by entitlement' do
        end
      end

      context 'when exceeding progear entitlement' do
        it 'highlights the progear text input' do
        end

        it 'estimates the incentive with the total weight limited by entitlement' do
        end
      end

      context 'when exceeding progear spouse entitlement' do
        it 'highlights the progear spouse text input' do
        end

        it 'estimates the incentive with the total weight limited by entitlement' do
        end
      end
    end
  end
end
