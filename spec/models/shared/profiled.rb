shared_examples 'profiled' do
  context 'validations' do
    it 'is invalid without name' do
      expect(subject.class.new).to have(1).error_on(:name)
    end
  end

  describe '#first_name' do
    it 'returns first name' do
      resource = subject.class.new(name: 'John Doe')
      expect(resource.first_name).to eql 'John'
    end
  end
end