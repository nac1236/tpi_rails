require 'rails_helper'

RSpec.describe Product, type: :model do
  # Base product --> product = Product.new(code:'asd123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50)
  context "validations" do

    it "ensures code presence" do
      product = Product.new(description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
      expect(product).to eq(false)
    end

    it "expected code format" do
      product = Product.new(code:'a123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
      expect(product).to eq(false)
    end

    it "ensures code uniqueness" do
      product1 = Product.new(code:'asd123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
      expect(product1).to eq(true)
      product2 = Product.new(code:'asd123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
      expect(product2).to eq(false)
    end

    it "ensures description presence" do
      product = Product.new(code:'a123456',detail:"A sample detail.",cost_per_unit:10.50).save  
      expect(product).to eq(false)
    end

    it "expected description size <= 200" do
      product = Product.new(code:'a123456', description: "

      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut porta sem at rutrum mollis. In sit amet nisi sagittis, viverra urna at, dignissim justo. In gravida nisl id diam efficitur, sed egestas augue mattis. Proin quis euismod dolor. Curabitur et neque maximus, egestas risus in, euismod tellus. Mauris non nibh neque. Nunc vestibulum scelerisque massa quis molestie. Cras imperdiet vestibulum lectus in suscipit. Donec rhoncus ipsum tellus, vel elementum turpis tincidunt a.
      
      Sed aliquet sollicitudin congue. Morbi lacus ipsum, vehicula sit amet odio nec, fermentum vestibulum erat. Sed imperdiet dolor et dictum ultricies. Curabitur convallis tincidunt finibus. Curabitur commodo sagittis massa sed cursus. Sed in magna eros. Etiam at eros aliquam, dapibus mi at, tincidunt mi. Pellentesque ultricies malesuada felis, quis imperdiet diam ultrices et.
      
      Nulla velit ipsum, sodales et leo vel, accumsan consequat ante. Nulla id felis nec ligula cursus varius vitae ac mauris. Praesent eget dolor efficitur, imperdiet dui eu, bibendum ligula. Etiam aliquet commodo lacus, venenatis sollicitudin mauris dapibus vel. Suspendisse vehicula odio eget erat blandit, sed dignissim tellus convallis. In commodo ornare nunc, ut sollicitudin sapien luctus sit amet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Lorem ipsum dolor sit amet, consectetur.", detail:"A sample detail.",cost_per_unit:10.50).save  
      expect(product).to eq(false)
    end

    it "ensures detail presence" do
      product = Product.new(code:'asd123456', description:"A sample descrition.",cost_per_unit:10.50).save
      expect(product).to eq(false)
    end

    it "ensures cost_per_unit presence" do
      product = Product.new(code:'asd123456', description:"A sample descrition.",detail:"A sample detail.").save
      expect(product).to eq(false)
    end

    it "should create a product" do
      product = Product.new(code:'asd123456', description:"A sample descrition.",detail:"A sample detail.",cost_per_unit:10.50).save
      expect(product).to eq(true)
    end

  end
end
