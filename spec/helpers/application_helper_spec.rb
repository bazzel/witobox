require 'spec_helper'

describe ApplicationHelper do
  describe "button_tag" do
    it "renders a button" do
      helper.button_tag.should have_tag("button", /Submit/) do
        with_tag "span"
      end
    end

    it "renders button with attributes" do
      helper.button_tag.should have_tag("button.button.positive")
      helper.button_tag.should have_tag("button[type=?]","submit")
    end

    it "renders button with a custom value" do
      helper.button_tag('Save').should have_tag("button", /Save/)
    end

  end
  
end
