require 'inifile'

class ConfigurationFileFacade

  def self.SaveConfigurations
    @configurations_hash = ConfigurationVisitor.Visit

    ini = IniFile.new( :filename => 'settings.ini', :encoding => 'UTF-8' )

    @configurations_hash.each do |rule, configurations|
      configurations.each do |configuration|
        case configuration.displayfield
        when DisplayField[:SelectBox]
          ini[rule][configuration.id] = configuration.value.join(',')
        else
          ini[rule][configuration.id] = configuration.value
        end
      end
    end

    ini.save
  end

  def self.LoadConfigurations
    @configurations_hash = ConfigurationVisitor.Visit

    ini = IniFile.new( :filename => 'settings.ini')

    @configurations_hash.each do |rule, configurations|
      configurations.each do |configuration|
        if(not ini[rule][configuration.id].nil?)
          case configuration.displayfield
          when DisplayField[:SelectBox]
            configuration.value = ini[rule][configuration.id].split(',')
          else
            configuration.value = ini[rule][configuration.id]
          end
        end
      end
    end
  end

end