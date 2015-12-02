feature "Ordering a coffee" do
  background do
    visit new_shop_path
    fill_in 'street number', with: '10'
    fill_in 'street', with: 'dupaty'
    fill_in 'suburb', with: 'Geelong'
    select 'VIC', from: 'shop_state'
    fill_in 'postcode', with: '1234'
    click_on 'Create Shop'
  end

  scenario "User can order coffee without signing in" do
    visit root_path
    expect(page).to have_text("Konoha Coffee Locations")
    click_on "New Order"
    fill_in "Name", with: "Tim"
    fill_in "Last name", with: "Silva"
    fill_in "Email", with: "silva.tim@gmail.com"
    select "Flat White", from: 'order_coffee_type'
    select "Soy milk", from: 'order_milk'
    choose "Large"
    select "03", from: 'order_pickup_time_4i'
    select "30", from: 'order_pickup_time_5i'
    fill_in "Additional comments", with: 'extra hot'
  end

  describe "show Stripe checkout", :js => true do
    before do
      click_button 'Pay with Card'
      stripe_iframe = all('iframe[name=stripe_checkout_app]').last
      Capybara.within_frame stripe_iframe do        
        fill_in "Email", :with => "railstestacc@gmail.com"
        fill_in "Card number", :with => "4242424242424242"
        fill_in "MM/YY", :with => "1219"
        fill_in "CVC", :with => "111"
        click_button "Pay $5.00"
        expect(current_path).to eq('/shops/7/orders')
        expect(page).to have_text('THAN YOU, TIM')
      end
    end
  end      
end

#feature 'Emailer' do
#  background do
        #will clear the message queue
    #clear_emails
    #visit email_trigger_path
         #Will find an email sent to test@example.com
         #and set `current_email`
    #open_email('silva.tim@gmail.com')
  #end

  #scenario 'following a link' do
  #  current_email.click_link 'your profile'
  #  expect(page).to have_content 'Profile page'
  #end

  #scenario 'testing for content' do
  #  expect(current_email).to have_content 'Welcome to Konoha Coffee, Tim'
  #end

  #end



