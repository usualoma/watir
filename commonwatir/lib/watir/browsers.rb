# watir/browsers
# Define browsers supported by Watir

Watir::Browser.support :name => 'ie', :class => 'Watir::IE', 
  :library => 'watir/ie', :gem => 'watir', 
  :options => [:speed, :visible]

Watir::Browser.support :name => 'firefox', :class => 'FireWatir::Firefox',
  :library => 'firewatir',
  :options => [
      :new_browser_connection_timeout,
      :new_browser_connection_rety_period,
      :ip_address,
      :port,
      :profile,
      :multiple_browser_xpi,
      :suppress_launch_process
      ]

Watir::Browser.support :name => 'safari', :class => 'Watir::Safari',
  :library => 'safariwatir'
