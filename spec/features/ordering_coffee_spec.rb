feature "Ordering a coffee" do
  background do
    #create a coffee shop
    #
  end

  scenario "User can order coffee without signing in" do
    visit root_path
    click_on "New Order"
    fill_in "Name" with: "Tim"
    ### and the rest

    ##Assert email
  end

end
