require 'rails_helper'

RSpec.describe 'pages/splash.html.erb', type: :view do
  it 'displays the splash page' do
    render
    expect(rendered).to match(/Nurozede App/)
  end

  it 'displays title' do
    render
    expect(rendered).to match(/Nurozede Budget App - Welcome/)
  end

  it 'displays the sign up button' do
    render
    expect(rendered).to match(/Sign Up/)
  end

  it 'displays the sign in button' do
    render
    expect(rendered).to match(/Log In/)
  end
end
