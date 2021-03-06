require 'rails_helper'


shared_examples "入力項目の有無" do
  let(:object_name) { described_class.to_s.underscore.to_sym }
  let(:model) { FactoryBot.build(object_name)}

  context "必須入力項目であること" do
    it "お名前が必須であること" do
      expect(model).not_to be_valid
      expect(model.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it "メールが必須であること" do
      expect(model).not_to be_valid
      expect(model.errors[:mail]).to include(I18n.t('errors.messages.blank'))
    end

    it "年齢が必須であること" do
      expect(model).not_to be_valid
      expect(model.errors[:age]).to include(I18n.t('errors.messages.blank'))
    end

    it "満足度が必須であること" do
      expect(model).not_to be_valid
      expect(model.errors[:score]).to include(I18n.t('errors.messages.blank'))
    end

    it "登録できないこと" do
      expect(model.save).to be_falsey
    end
  end

  context "任意入力であること" do
    it "ご意見・ご要望が任意であること" do
      expect(model).to be_invalid
      expect(model.errors[:request]).not_to include(I18n.t('errors.messages.blank'))
    end
  end
end

  shared_examples 'メールアドレスの形式' do
    let(:object_name) { described_class.to_s.underscore.to_sym}
    let(:model) { FactoryBot.build(object_name) }

    context '不正な形式のメールアドレスの場合' do
      it 'エラーになること' do
        model.mail = "taro.tanaka"
        expect(model).not_to be_valid
        expect(model.errors[:mail]).to include(I18n.t('errors.messages.invalid'))
      end
    end
  end

  



shared_examples "価格の表示" do
  let(:object_name) { described_class.to_s.underscore.to_sym}
  let(:model) { FactoryBot.build(object_name)}

  describe "税込価格が計算されること" do
    it "10%が加算されること" do
      expect(model.tax_included_price(100)).to eq 110
    end

    it '10%加算され、小数が切り捨てられること' do
      expect(model.tax_included_price(101)).to eq 111
    end
  end
end


shared_examples "満足度の表示" do
  let(:object_name) { described_class.to_s.underscore.to_sym}
  let(:model) { FactoryBot.build(object_name)}

  it "満足度が「悪い」になること" do
    model.score = 1
    expect(model.view_score).to eq I18n.t('common.score.bad')
  end

  it '満足度が「普通」になること' do
    model.score = 2
    expect(model.view_score).to eq I18n.t('common.score.normal')
  end

  it '満足度が「不明」になること' do
    model.score = 0
    expect(model.view_score).to eq I18n.t('common.score.unknown')

    model.score = 4
    expect(model.view_score).to eq I18n.t('common.score.unknown')
  end
end