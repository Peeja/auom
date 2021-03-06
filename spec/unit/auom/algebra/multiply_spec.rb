# encoding: UTF-8

require 'spec_helper'

describe AUOM::Algebra, '#multiply' do
  subject { object.multiply(operand) }

  let(:object) { AUOM::Unit.new(*arguments) }

  context 'with unitless unit' do
    let(:arguments) { [2] }

    context 'when operand is a fixnum' do
      let(:operand) { 2 }

      it_should_behave_like 'an operation'

      it { should eql(AUOM::Unit.new(4)) }
    end

    context 'when operand is a unitless unit' do
      let(:operand) { AUOM::Unit.new(2) }

      it_should_behave_like 'an operation'

      it { should eql(AUOM::Unit.new(4)) }
    end

    context 'when operand is a unitful unit' do
      let(:operand) { AUOM::Unit.new(2, :meter) }

      it_should_behave_like 'an operation'

      it { should eql(AUOM::Unit.new(4, :meter)) }
    end
  end

  context 'with unitful unit' do
    let(:arguments) { [2, :meter, :kilogramm] }

    context 'when operand is a fixnum' do
      let(:operand) { 2 }

      it_should_behave_like 'an operation'

      it { should eql(AUOM::Unit.new(4, :meter, :kilogramm)) }
    end

    context 'when operand is a unitless unit' do
      let(:operand) { AUOM::Unit.new(2) }

      it_should_behave_like 'an operation'

      it { should eql(AUOM::Unit.new(4, :meter, :kilogramm)) }
    end

    context 'when operand is a unitful unit' do

      context 'and units get added to numerator' do
        let(:operand) { AUOM::Unit.new(2, :meter) }

        it_should_behave_like 'an operation'

        it { should eql(AUOM::Unit.new(4, [:meter, :meter], :kilogramm)) }
      end

      context 'and units get added to denominator' do
        let(:operand) { AUOM::Unit.new(2, [], :euro) }

        it_should_behave_like 'an operation'

        it { should eql(AUOM::Unit.new(4, :meter, [:euro, :kilogramm])) }
      end

      context 'and units cancle each other' do
        let(:operand) { AUOM::Unit.new(2, [], :meter) }

        it_should_behave_like 'an operation'

        it { should eql(AUOM::Unit.new(4, [], :kilogramm)) }
      end
    end
  end
end
