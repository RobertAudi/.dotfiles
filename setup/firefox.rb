#!/usr/bin/env ruby

require 'fileutils'

FIREFOX_BASE_DIR = File.expand_path("~/Library/Application Support/Firefox")

def default_firefox_profile_path
  profile_ini = File.expand_path("profiles.ini", FIREFOX_BASE_DIR)

  unless File.exists?(profile_ini)
    $stderr.puts "profile.ini not found"
    exit(1)
  end

  profiles = File.read(profile_ini)
  matches = profiles.match(/(?<profile>\[.+\]\n(?:[^\n]+=[^\n]*\n)*Default=1\n(?:[^\n]+=[^\n]*\n)*)/)

  if matches.nil?
    $stderr.puts "default profile not found"
    exit 1
  end

  profile = matches[:profile].match(/(?:(?<relative>IsRelative=[10])\n|(?<path>Path=[^\n]+?)\n)+/m)

  if profile.nil?
    $stderr.puts "profile path not found"
    exit(1)
  end

  is_relative = profile[:relative].to_s.end_with?('1')
  path = profile[:path].to_s.slice(/=(.+)/, 1)
  full_path = File.expand_path(path, is_relative ? FIREFOX_BASE_DIR : nil)

  full_path
end

def install_custom_firefox_styles
  profile_path = default_firefox_profile_path
  chrome_path = File.expand_path('chrome', profile_path)

  unless File.exist?(chrome_path)
    FileUtils.mkdir(chrome_path)
  end

  unless File.exist?(File.expand_path('userChrome.css', chrome_path))
    user_chrome = File.expand_path('~/.mozilla/firefox/default/chrome/userChrome.css')

    if File.exist?(user_chrome)
      FileUtils.cp(File.realpath(user_chrome), chrome_path)
    end
  end

  unless File.exist?(File.expand_path('userContent.css', chrome_path))
    user_content = File.expand_path('~/.mozilla/firefox/default/chrome/userContent.css')

    if File.exist?(user_content)
      FileUtils.cp(File.realpath(user_content), chrome_path)
    end
  end
end

install_custom_firefox_styles
