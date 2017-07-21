RSpec.describe ApplicationHelper, type: :helper do
  let(:site_title) { 'Move.mil' }
  let(:site_tagline) { 'Official DOD Moving Portal' }

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

  describe '#page_title' do
    context 'when @page_title is not set' do
      it 'returns a string with the site title and site description.' do
        expect(helper.page_title).to eq("#{site_title} — #{site_tagline}")
      end
    end

    context 'when @page_title is set' do
      it 'returns a string with the page title and site title.' do
        @page_title = 'foo'
        expect(helper.page_title).to eq("foo — #{site_title}")
      end
    end
  end
end
