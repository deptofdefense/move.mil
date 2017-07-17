RSpec.describe ApplicationHelper, type: :helper do
  describe '#abbr_tag' do
    context 'withoout HTML options' do
      it 'returns a string' do
        expect(helper.abbr_tag('dod')).to eq('<abbr title="Department of Defense">DOD</abbr>')
      end
    end

    context 'with HTML options' do
      it 'returns a string' do
        expect(helper.abbr_tag('dod', class: 'foo bar')).to eq('<abbr title="Department of Defense" class="foo bar">DOD</abbr>')
      end
    end
  end
end
