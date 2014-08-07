#        ____ _____ ___     ____      _____ ____    _____ _ ___
#       / __//____//__ \   /__  \    /____//__  \  /____//_X__/
#      ( (    __   __| |   ___) /     __   ___) / ____  ___
#       \ \  / / ,/,/| |  /   _/     / /  /   _/ / __/ / _ \
#    ____) )/ /,/ /__| | / /\ \     / /  / /\ \ / /__ / / \ \
#   /_____//_//________|/_/ /_/    /_/  /_/ /_//____//_/   \_\
#
#                     BATTLE SCENARIO SIMULATOR
#

class Captain
  def initialize(helm, tactical)
    @helm, @tactical = helm, tactical
    @status = "exploring"
  end

  def status
    @status
  end

  def command
    loosing ? retreat : return_fire

    nil
  end

  private

  def retreat
    @helm.engage(8.0)
    @status = "retreating"
  end

  def return_fire
    @tactical.fire_phasers
    @status = "fighting"
  end

  def loosing
    Ship.damage > 0.5
  end
end

class Helm
  def initialize(console)
    @console = console
  end

  def engage(factor)
    console.engage_warp_drive(factor)
  end
end

class Tactical
  def initialize(console)
    @console = console
  end

  def fire_phasers
    console.fire_phasers
  end
end

class Ship
  @@damage = 0.0

  def self.damage
    @@damage
  end

  def self.add_damage(percent)
    return if @@damage >= 1.0
    @@damage += percent
  end

  def self.destroyed
    @@damage >= 1.0
  end
end

