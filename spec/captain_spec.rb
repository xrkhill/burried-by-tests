require "captain"

RSpec.describe Captain do
  before do
    @helm = instance_double("Helm")
    @tactical = instance_double("Tactical")
    @ship = class_double("Ship").as_stubbed_const

    @captain = Captain.new(@helm, @tactical)
  end

  it "status is exploring by default" do
    expect(@captain.status).to eq("exploring")
  end

  it "command sets status to retreating when loosing" do
    allow(@ship).to receive(:damage).and_return(0.6)
    allow(@helm).to receive(:engage).with(8.0)

    @captain.command

    expect(@captain.status).to eq("retreating")
  end

  it "command sets status to fighting when winning" do
    allow(@ship).to receive(:damage).and_return(0.3)
    allow(@tactical).to receive(:fire_phasers)

    @captain.command

    expect(@captain.status).to eq("fighting")
  end

  it "retreats when appropriate" do
    allow(@ship).to receive(:damage).and_return(0.6)

    expect(@helm).to receive(:engage).with(8.0)

    @captain.command
  end

  it "fights back when appropriate" do
    allow(@ship).to receive(:damage).and_return(0.3)

    expect(@tactical).to receive(:fire_phasers)

    @captain.command
  end
end

