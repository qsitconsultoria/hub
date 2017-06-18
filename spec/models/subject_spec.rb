require 'spec_helper'

describe Subject do
  context 'validations' do
    let(:subject) { build :subject }

    it 'is invalid without name' do
      expect(Subject.new).to have(1).error_on(:name)
    end

    it 'is invalid with duplicated name for the same course' do
      create :subject, name: 'Intro'
      duplicated = Subject.new(name: 'Intro')
      expect(duplicated).to have(1).error_on(:name)
    end

    it 'is valid with duplicated name for different courses' do
      rails = create :course, name: 'Rails'
      design = create :course, name: 'Design'

      rails_intro = create :subject, name: 'Intro', course: rails
      design_intro = Subject.new(name: 'Intro', course: design)

      expect(design_intro).to be_valid
    end

    it 'is invalid without slug' do
      expect(Subject.new).to have(1).error_on(:slug)
    end

    it 'is invalid with duplicated slug for the same course' do
      create :subject, slug: 'rails-for-designers'
      duplicated = Subject.new(slug: 'rails-for-designers')
      expect(duplicated).to have(1).error_on(:slug)
    end

    it 'is valid with duplicated name for different courses' do
      rails = create :course, name: 'Rails'
      design = create :course, name: 'Design'

      rails_intro = create :subject, name: 'Intro', course: rails
      design_intro = Subject.new(name: 'Intro', course: design)

      expect(design_intro).to be_valid
    end
  end

  context 'validations' do
    it 'belongs to Course' do
      rails = create :course
      intro = create :subject, course: rails
      expect(intro.course).to eql rails
    end
  end
end
