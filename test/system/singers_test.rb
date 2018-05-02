require "application_system_test_case"

class SingersTest < ApplicationSystemTestCase
  setup do
    @singer = singers(:one)
  end

  test "visiting the index" do
    visit singers_url
    assert_selector "h1", text: "Singers"
  end

  test "creating a Singer" do
    visit singers_url
    click_on "New Singer"

    fill_in "Name", with: @singer.name
    click_on "Create Singer"

    assert_text "Singer was successfully created"
    click_on "Back"
  end

  test "updating a Singer" do
    visit singers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @singer.name
    click_on "Update Singer"

    assert_text "Singer was successfully updated"
    click_on "Back"
  end

  test "destroying a Singer" do
    visit singers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Singer was successfully destroyed"
  end
end
