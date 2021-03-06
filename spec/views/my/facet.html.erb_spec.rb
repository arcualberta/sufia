require 'spec_helper'

# Note: this is a direct copy of the corresponding test in Blacklight
# with changes for "views/my" instead of "views/catalog"

describe "my/facet.html.erb", :type => :view do
  let(:display_facet) { double }
  let(:blacklight_config) { Blacklight::Configuration.new }
  before do
    blacklight_config.add_facet_field "xyz", label: "Facet title"
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
    stub_template "my/_facet_pagination.html.erb" => "pagination"
    assign :facet, blacklight_config.facet_fields["xyz"]
    assign :display_facet, display_facet
  end

  it "should have the facet title" do
    allow(view).to receive(:render_facet_limit)
    render
    expect(rendered).to have_selector "h3", text: "Facet title"
  end

  it "should render facet pagination" do
    allow(view).to receive(:render_facet_limit)
    render
    expect(rendered).to have_content "pagination"
  end

  it "should render the facet limit" do
    expect(view).to receive(:render_facet_limit).with(display_facet, layout: false)
    render
  end
end
