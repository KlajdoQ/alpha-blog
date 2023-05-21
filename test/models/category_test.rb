require 'test_helper'

class CategoryTest < ActiveSupport::TestCase 


    def setup 
        @category = Category.new(name: "Sports") #what is in setup runs first before the test so we can use it as a first step for each test
    end

    test "category should be valid" do 
        assert @category.valid?
    end

    test "name shoud be present" do 
        @category.name =" "
        assert_not @category.valid?
    end

    test "name should be unique" do 
        @category.save 
        @category2 = Category.new(name: "Sports")
        assert_not @category2.valid?
    end

    test "name should not be too long" do 
        @category.name = "a" * 26
        assert_not @category.valid?
    end

    test "name should not be too short" do 
        @category.name = "aa" 
        assert_not @category.valid?
    end
end