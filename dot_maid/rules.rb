require 'colorize'
require 'ruby-growl'
require 'fileutils'
require 'yaml'
require 'pp'
require 'terminal-notifier-guard'
require_relative 'icon'

g = Growl.new "localhost", "Maid Notifaction", "GNTP"

TerminalNotifier::Guard.notify('Hello World')
Maid.rules do

  rule 'Get Mime Type' do
    dir('~/Downloads/*').each do |path|
      mimetype = content_types(path)
      puts "\e[38;5;13m#{File.basename(path)}\e[38;5;45m#{File.extname(path)}\e[38;5;243m ---> #{mimetype}"
    end
  end

  rule 'Trash temps from Downloads' do
    puts "\n--------------------------------------------\n\033[32mRemove temps from Downloads\033[0m"
    trash dir('~/Downloads/*.torrent')
  end

  #
  # Get rid of the zip file if we have a matching dir
  #
  rule 'Remove unzipped file if zipped file exists' do
    puts "--------------------------------------------\n\033[32mRemove unzipped file if zipped file exists\033[0m"
    found = dir('~/Downloads/**/*').select do |path|
      result = path.match(/(.*)\.zip$/) || path.match(/(.*)\.tar\.gz$/)
      if result
        File.exist?(result[1])
      end
    end
    trash found
  end

  #
  # Get rid of the zip file if we have a matching dir
  #
  # rule '3D Models: Remove unzipped file if zipped file exists' do
  #   puts "--------------------------------------------\n\033[32m3D Models: Remove unzipped file if zipped file exists\033[0m"
  #   found = dir('~/Dropbox/3D/models/**/*').select do |path|
  #     result = path.match(/(.*)\.zip$/)
  #     if result
  #       File.exist?(result[1])
  #     end
  #   end
  #   trash found
  # end


  #   .d8b.  d8888b. d8888b. .d8888.
  #  d8' `8b 88  `8D 88  `8D 88'  YP
  #  88ooo88 88oodD' 88oodD' `8bo.
  #  88~~~88 88~~~   88~~~     `Y8b.
  #  88   88 88      88      db   8D
  #  YP   YP 88      88      `8888Y'
  #
  #
  # Clean App Names
  #
  rule 'Clean Cracked Apps Names' do
    dir('~/Downloads/01 Apps/*').each do |path|
      if File.directory?(path)
        if result = path.match(/(.*)Multil/) || result = path.match(/(.*)[\._][Mm][Aa][Cc][oO][sS][xX]/)
          begin
            rename(path, result[1].gsub(/(\D)[\._](\D)/, '\1 \2'))
          rescue
            puts "Couldn't rename #{path}"
          end
        end
      end
    end
  end

  #  .88b  d88.  .d88b.  db    db d888888b d88888b .d8888.
  #  88'YbdP`88 .8P  Y8. 88    88   `88'   88'     88'  YP
  #  88  88  88 88    88 Y8    8P    88    88ooooo `8bo.
  #  88  88  88 88    88 `8b  d8'    88    88~~~~~   `Y8b.
  #  88  88  88 `8b  d8'  `8bd8'    .88.   88.     db   8D
  #  YP  YP  YP  `Y88P'     YP    Y888888P Y88888P `8888Y'
  #
  rule 'Clean Up Movies' do
    dir('~/Downloads/02 Movies/*').each do |path|
      if File.directory?(path)
        # Start the sizeof
        begin
          if (size_of(file) < 100000000 && !File.directory?(file))
            puts "Killing sample or garbage file #{file}\n"
            trash(file)
            next
          end
        rescue
          puts "\033[31mError getting path size of: #{path}\n\033[0m"
        end
      end
    end
  end
  # rule 'Move Movies' do
  #   puts "--------------------------------------------\n\033[32mMove Movies\033[0m"
  #   dir(['~/Downloads/00 Completed/**/*.mp4', '~/Downloads/00 Completed/**/*.avi', '~/Downloads/00 Completed/**/*.mkv']).each do |path|
  #     # if !path.match(/00 Movies/)
  #       # puts "Path match"
  #     # end
  #     if !path.match(/00 Movies/) && !path.match(/00 TV/)
  #       # Iterate through all the files
  #       dir(File.dirname(path)+"*/*[avi|mkv|mp4]").each do |file|
  #         # Files/Directories to ignore
  #         if file == '~/Downloads/00 Completed'
  #           puts "Ignoring #{file}\n".yellow
  #           next
  #         end
  #         if File.directory?(file)
  #           # g.add_notification "Duplicate", nil, MAID_ICONS::DUPLICATE
  #           # g.notify "Duplicate", "Rule: Remove duplicate files", "Remove duplicate file #{File.basename(file)}"
  #           # puts say_hello("balls")
  #           puts "File exists as #{file}\n".blue
  #           next
  #         end

  #         # Start the sizeof
  #         begin
  #           if (size_of(file) < 100000000 && !File.directory?(file))
  #             puts "Killing sample or garbage file #{file}\n"
  #             trash(file)
  #             next
  #           end
  #         rescue
  #           puts "\033[31mError getting path size of: #{path}\n\033[0m"
  #         end

  #         # Check if it's a directory
  #         begin
  #           if (Dir.entries(File.dirname(file)) - %w{ . .. }).empty?
  #             trash(File.dirname(file))
  #           end
  #         rescue
  #           puts "\033[31mError removing #{File.dirname(path)}\n\033[0m"
  #         end

  #         # Check for TV
  #         if file.match(/[sS][0-9][0-9][eE][0-9][0-9]/)
  #           move(file, '~/Downloads/00 TV')
  #         else
  #           move(file, '~/Downloads/00 Completed/00 Movies')
  #         end

  #       end
  #     end
  #   end
  # end

  #  d88888b  .d88b.  d8b   db d888888b .d8888.
  #  88'     .8P  Y8. 888o  88 `~~88~~' 88'  YP
  #  88ooo   88    88 88V8o 88    88    `8bo.
  #  88~~~   88    88 88 V8o88    88      `Y8b.
  #  88      `8b  d8' 88  V888    88    db   8D
  #  YP       `Y88P'  VP   V8P    YP    `8888Y'
  #
  rule 'Fonts in Downloads' do
    puts "--------------------------------------------\n\033[32mFonts in Downloads\033[0m"
    dir(%w(~/Downloads/*.ttf ~/Downloads/*.otf ~/Downloads/**/*.ttf ~/Downloads/**/*.otf ~/Downloads/**/*.TTF ~/Downloads/**/*.OTF)).each do |path|
      begin
        if !File.dirname(path).match(/Downloads$/) && !File.dirname(path).match(/04 Design/) && !File.dirname(path).match(/Wordpress/) && !path.match(/\.app/) && !File.dirname(path).match(/11 Ripped Sites/)
          # Let's clean bs files in there
          dir([File.dirname(path)+"/*.txt", File.dirname(path)+"/*.pdf", File.dirname(path)+"/*.jpg",File.dirname(path)+"/*.png"]).each do |rdmepath|
            trash rdmepath
          end
          # Now move the dir to Fonts dir
          move(File.dirname(path), '~/Dropbox/Fonts')
        end
        # if File.dirname(path).match(/Downloads$/) || File.dirname(path).match(/01 Design$/)
        #   move(path, '~/Dropbox/Fonts')
        # end
      rescue
        puts "\e[38;5;243mSkipping #{path} since we've already moved its parent dir"
      end
    end
  end



  #  d8888b.  .d88b.  db   d8b   db d8b   db db       .d88b.   .d8b.  d8888b. .d8888.
  #  88  `8D .8P  Y8. 88   I8I   88 888o  88 88      .8P  Y8. d8' `8b 88  `8D 88'  YP
  #  88   88 88    88 88   I8I   88 88V8o 88 88      88    88 88ooo88 88   88 `8bo.
  #  88   88 88    88 Y8   I8I   88 88 V8o88 88      88    88 88~~~88 88   88   `Y8b.
  #  88  .8D `8b  d8' `8b d8'8b d8' 88  V888 88booo. `8b  d8' 88   88 88  .8D db   8D
  #  Y8888D'  `Y88P'   `8b8' `8d8'  VP   V8P Y88888P  `Y88P'  YP   YP Y8888D' `8888Y'
  #
  DOWNLOAD_TYPES = {
    '14 Windows' => %w(com.microsoft.windows-executable),
    '03 Apps' => %w(com.apple.application com.apple.installer-package-archive public.executable com.apple.disk-image),
    '06 Docs' => %w(com.microsoft.word.doc com.adobe.pdf public.rtf application/vnd.openxmlformats-officedocument.wordprocessingml.template public.log com.apple.iwork.pages.pages com.apple.iwork.keynote.sffkey),
    '05 Archives' => %w(public.archive application/rar-compressed),
    '04 Design' => %w(com.adobe.photoshop-image com.adobe.illustrator.ai-image com.adobe.encapsulated-postscript com.adobe.indesign.indd-document),
    '07 Images' => 'public.image',
    '08 Scripts' => %w(public.source-code public.script public.html text/css dyn.ah62d4rv4ge8024psse),
    '09 Books' => %w(application/epub+zip),
    '10 Data' => %w(text/comma-separated-values com.microsoft.excel.xls public.json)
  }
  DOWNLOAD_TYPES.each do |sub_dir, types|
    rule "Move downloaded #{sub_dir}" do
      puts "--------------------------------------------\n\033[36mMove downloaded #{sub_dir}\033[0m"
      if !File.directory?("~/Downloads/#{sub_dir}")
        puts "~/Downloads/#{sub_dir} is not a directory"
        mkdir("~/Downloads/#{sub_dir}")
      end
      move where_content_type(dir('~/Downloads/*.*'), types), "~/Downloads/#{sub_dir}"
    end
  end

  #   .o88b. db      d88888b  .d8b.  d8b   db db    db d8888b.
  #  d8P  Y8 88      88'     d8' `8b 888o  88 88    88 88  `8D
  #  8P      88      88ooooo 88ooo88 88V8o 88 88    88 88oodD'
  #  8b      88      88~~~~~ 88~~~88 88 V8o88 88    88 88~~~
  #  Y8b  d8 88booo. 88.     88   88 88  V888 88b  d88 88
  #   `Y88P' Y88888P Y88888P YP   YP VP   V8P ~Y8888P' 88

  #
  # Clean Up Homebrew
  #
  # rule 'Clean /Library/Caches/Homebrew/' do
  #   puts "--------------------------------------------\n\033[33mClean /Library/Caches/Homebrew/\033[0m"
  #   dir('/Library/Caches/Homebrew/*.tar.*').each do |path|
  #     trash path if File.mtime(path) < 90.days.ago
  #   end
  #   dir('/Library/Caches/Homebrew/*.tgz').each do |path|
  #     trash path if File.mtime(path) < 90.days.ago
  #   end
  #   dir('/Library/Caches/Homebrew/*.tbz').each do |path|
  #     trash path if File.mtime(path) < 90.days.ago
  #   end
  # end


  # Cleaning up after Maid
  # ----------------------
  # This one should be after all the other 'Downloads' and 'Outbox' rules
  # rule 'Remove empty directories && Kill Stupid .DS_Store files' do
    # puts "--------------------------------------------\n\033[33mRemove empty directories && Kill Stupid .DS_Store files\033[0m"
    # dir(%w(~/Downloads/**/.DS_Store ~/Dropbox/**/.DS_Store ~/Git/**/.DS_Store ~/Code/**/.DS_Store)).each do |path|
      # File.delete(path)
    # end
    # dir(%w(~/Downloads/**/* ~/Dropbox/**/*)).each do |path|
      # if File.directory?(path) && (Dir.entries(path) - %w{ . .. }).empty? && !path.match(/\.app/)
        # trash path
      # end
    # end
  # end

  # Trash
  # rule 'Take out the Trash' do
  #   puts "--------------------------------------------\n\033[31mTake out the Trash\033[0m"
  #   dir('~/.Trash/*').each do |p|
  #     remove(p) if accessed_at(p) > 14.days.ago
  #   end
  #   puts '--------------------------------------------'
  # end


end

