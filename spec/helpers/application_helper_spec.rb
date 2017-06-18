require 'spec_helper'

describe ApplicationHelper do
  describe 'button_to(label, url, &block)' do
    it 'works like link_to with predefined classes' do
      button = button_to('Lorem', '#')
      link = link_to('Lorem', '#', class: 'btn btn--primary')

      expect(button).to eql link
    end

    it 'works with blocks' do
      button = button_to '#' do
        '<span>Lorem</span>'
      end

      link = link_to '#', class: 'btn btn--primary' do
        '<span>Lorem</span>'
      end

      expect(button).to eql link
    end

    # TODO: Make it work with other classes
    # it 'works with custom classes' do
    #   button = button_to('Lorem', '#', class: 'other-class')
    #   link = link_to('Lorem', '#', class: 'btn btn--primary other-class')

    #   expect(button).to eql link
    # end

    # it 'works with custom classes and blocks' do
    #   button = button_to '#', class: 'other-class' do
    #     '<span>Lorem</span>'
    #   end

    #   link = link_to '#', class: 'btn btn--primary other-class' do
    #     '<span>Lorem</span>'
    #   end

    #   expect(button).to eql link
    # end
  end

  describe '.nav_status_class(string, controller)' do
    before do
      allow(helper).to receive(:params) { {controller: 'courses'} }
    end

    context 'when provided controller does not match current controller' do
      it 'returns the string' do
        expect(helper.nav_status_class('button featured', 'users')).to eql 'button featured'
      end
    end

    context 'when provided controller matches current controller' do
      it 'returns the original string appended with "active"' do
        expect(helper.nav_status_class('button featured', 'courses')).to eql 'button featured is-active'
      end
    end
  end
end
