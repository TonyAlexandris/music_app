require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  subject(:user) {FactoryBot.build(:user)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  it "doesn't accept passwords shorter than 6" do
    short_pass = FactoryBot.build(:user, password: 'malic')
    long_pass = FactoryBot.build(:user, password: 'malice')
    expect(short_pass).to_not be_valid
    expect(long_pass).to be_valid
  end

  describe '#reset_session_token!' do
    it "changes session token" do
      initial = subject.session_token
      subject.reset_session_token!
      expect(subject.session_token).to_not eq(initial)
    end
  end

  describe '#is_password?' do
    it "confirms password using password digest" do
      subject.save
      expect(subject.is_password?('qwerty')).to eq(true)
      expect(subject.is_password?('qwerTy')).to eq(false)
    end
  end

  describe '::find_by_credentials' do
    it "returns user given email and password" do
      person = FactoryBot.create(:user, password: 'malice', email: 'a@b.com')
      expect(User.find_by_credentials('a@b.com', 'malice')).to eq(person)
      expect(User.find_by_credentials('a@c.com', 'malice')).to eq(nil)
      expect(User.find_by_credentials('a@b.com', 'chalice')).to eq(nil)
    end
  end

end