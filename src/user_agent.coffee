class window.UserAgentParser

  Versions =
    Firefox       : /firefox\/([\d\w\.\-]+)/i
    IE            : /msie\s([\d\.]+[\d])/i
    Chrome        : /chrome\/([\d\w\.\-]+)/i
    Safari        : /version\/([\d\w\.\-]+)/i
    Ps3           : /([\d\w\.\-]+)\)\s*$/i
    Psp           : /([\d\w\.\-]+)\)?\s*$/i

  Browsers =
    Konqueror     : /konqueror/i
    Chrome        : /chrome/i
    Safari        : /safari/i
    IE            : /msie/i
    Opera         : /opera/i
    PS3           : /playstation 3/i
    PSP           : /playstation portable/i
    Firefox       : /firefox/i

  OS =
    WindowsVista  : /windows nt 6\.0/i
    Windows7      : /windows nt 6\.\d+/i
    Windows2003   : /windows nt 5\.2/i
    WindowsXP     : /windows nt 5\.1/i
    Windows2000   : /windows nt 5\.0/i
    OSX           : /os x (\d+)[._](\d+)/i
    Linux         : /linux/i
    Wii           : /wii/i
    PS3           : /playstation 3/i
    PSP           : /playstation portable/i
    Ipad          : /\(iPad.*os (\d+)[._](\d+)/i
    Iphone        : /\(iPhone.*os (\d+)[._](\d+)/i

  Platform =
    Windows       : /windows/i
    Mac           : /macintosh/i
    Linux         : /linux/i
    Wii           : /wii/i
    Playstation   : /playstation/i
    Ipad          : /ipad/i
    Ipod          : /ipod/i
    Iphone        : /iphone/i
    Android       : /android/i
    Blackberry    : /blackberry/i

  Type =
    Mobile       : /Mobile/i

  constructor: (source = navigator.userAgent) ->
    @source           = source.replace(/^\s*/, '').replace(/\s*$/, '')
    @browser_name     = browser_name @source
    @browser_version  = browser_version @source
    @os               = os @source
    @platform         = platform @source
    @type             = type @source
    @mobile           = @type is 'mobile'

    html = document.getElementsByTagName('html')[0]
    html.className += ' ' + @browser_name
    html.className += ' ' + @platform
    html.className += ' ' + @type

  browser_name = (string)->
    switch true
      when Browsers.Konqueror.test string  then 'konqueror'
      when Browsers.Chrome.test string     then 'chrome'
      when Browsers.Safari.test string     then 'safari'
      when Browsers.IE.test string         then 'ie'
      when Browsers.Opera.test string      then 'opera'
      when Browsers.PS3.test string        then 'ps3'
      when Browsers.PSP.test string        then 'psp'
      when Browsers.Firefox.test string    then 'firefox'
      else 'unknown'


  browser_version = (string)->
    switch browser_name(string)
      when 'chrome'
        RegExp.$1 if Versions.Chrome.test string
      when 'safari'
        RegExp.$1 if Versions.Safari.test string
      when 'firefox'
        RegExp.$1 if Versions.Firefox.test string
      when 'ie'
        RegExp.$1 if Versions.IE.test string
      when 'ps3'
        RegExp.$1 if Versions.Ps3.test string
      when 'psp'
        RegExp.$1 if Versions.Psp.test string
      else
        regex = /#{name}[\/ ]([\d\w\.\-]+)/i
        RegExp.$1 if regex.test string


  os = (string)->
    switch true
      when OS.WindowsVista.test string then 'windows vista'
      when OS.Windows7.test string     then 'windows 7'
      when OS.Windows2003.test string  then 'windows 2003'
      when OS.WindowsXP.test string    then 'windows XP'
      when OS.Windows2000.test string  then 'windows 2000'
      when OS.Linux.test string        then 'linux'
      when OS.Wii.test string          then 'wii'
      when OS.PS3.test string          then 'playstation'
      when OS.PSP.test string          then 'playstation'
      when OS.OSX.test string          then string.match(OS.OSX)[0].replace('_','.')
      when OS.Ipad.test string         then string.match(OS.Ipad)[0].replace('_','.')
      when OS.Iphone.test string       then string.match(OS.Iphone)[0].replace('_','.')
      else 'unknown'

  platform = (string)->
    switch true
      when Platform.Windows.test string     then "windows"
      when Platform.Mac.test string         then "mac"
      when Platform.Android.test string     then "android"
      when Platform.Blackberry.test string  then "blackberry"
      when Platform.Linux.test string       then "linux"
      when Platform.Wii.test string         then "wii"
      when Platform.Playstation.test string then "playstation"
      when Platform.Ipad.test string        then "ipad"
      when Platform.Ipod.test string        then "ipod"
      when Platform.Iphone.test string      then "iphone"
      else 'unknown'

  type = (string)->
    switch true
      when Type.Mobile.test string     then "mobile"
      else 'desktop'

window.userAgent = new window.UserAgentParser
