Maid.rules do

  rule 'Trash temps from Downloads' do
    puts "\n--------------------------------------------\n\033[32mMove temps from Downloads\033[0m"
    trash dir('~/Downloads/*.torrent')
    # move(dir('~/Downloads/**/*.[o|t]tf'),'~/Dropbox/Fonts/')
    # puts "\n--------------------------------------------"
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
  # Move Cracked apps
  #
  rule 'Move Cracked Apps' do
    puts "--------------------------------------------\n\033[32mMove Cracked Apps\033[0m"
    dir(%w(~/Downloads/**/*CORE* ~/Downloads/**/*XFORCE* ~/Downloads/**/*keygen* ~/Downloads/**/*KEYGEN* ~/Downloads/**/*crack* ~/Downloads/**/*serial*)).each do |path|
      if !path.match(/\/01 Apps/)
        if File.directory?(path)
          # If we are a subdirectory of an app, move the app itself
          if !File.dirname(path).match(/00 Completed$/) && !File.dirname(path).match(/Downloads$/)
            move(File.dirname(path), '~/Downloads/00 Completed/01 Apps')
          else
            if !File.dirname(path).match(/Downloads$/)
              move(path, '~/Downloads/00 Completed/01 Apps')
            end
          end
        else
          # If it's a file we found, move the parent directory
          move(File.dirname(path), '~/Downloads/00 Completed/01 Apps')
        end
      end
    end
    move(dir('~/Downloads/00 Completed/*.dmg'), '~/Downloads/00 Completed/01 Apps')
  end

  #
  # Clean the name of Cracked Apps
  #
  rule 'Clean Cracked Apps Names' do
    dir('~/Downloads/00 Completed/01 Apps/*').each do |path|
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

  #
  # Move just the movie file and kill the rest
  #
  rule 'Move Movies' do
    puts "--------------------------------------------\n\033[32mMove Movies\033[0m"
    dir(['~/Downloads/00 Completed/**/*.mp4', '~/Downloads/00 Completed/**/*.avi', '~/Downloads/00 Completed/**/*.mkv']).each do |path|
      if !path.match(/\/00 Movies/)
        begin
          if (size_of(path) < 100000000)
            remove(path)
          else
            if path.match(/[sS][0-9][0-9][eE][0-9][0-9]/)
              move(path, '~/Downloads/00 Completed/00 Movies/00 TV')
            else
              move(path, '~/Downloads/00 Completed/00 Movies')
              if (File.dirname(path) != '/Users/eboney/Downloads/00 Completed')
                trash(File.dirname(path))
              end
            end
          end
        rescue
          puts "Error getting path size of: #{path}\n"
        end
      end
    end
  end
  # rule "\033[32mMac OS X applications in zip files\033[0m" do
  #   puts "--------------------------------------------"
  #   found = dir('~/Downloads/*.zip').select { |path|
  #     zipfile_contents(path).any? { |c| c.match(/\.app$/) }
  #   }
  #   trash(found)
  #   puts "\n--------------------------------------------"
  #
  # end
  #

  #
  # Cleanup Fonts in Downloads
  #
  rule 'Fonts in Downloads' do
    puts "--------------------------------------------\n\033[32mFonts in Downloads\033[0m"
    dir(%w(~/Downloads/*.ttf ~/Downloads/*.otf ~/Downloads/**/*.ttf ~/Downloads/**/*.otf ~/Downloads/**/*.TTF ~/Downloads/**/*.OTF)).each do |path|
      begin
        if !File.dirname(path).match(/Downloads$/) && !File.dirname(path).match(/01 Design$/) && !File.dirname(path).match(/10 Wordpress/) && !path.match(/\.app/) && !File.dirname(path).match(/11 Ripped Sites/)
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
        puts "Skipping #{path} since we've already moved its parent dir"
      end
    end
  end

  # rule 'Get Mime Type' do
  #   dir('~/Downloads/**/*.psd').each do |path|
  #     mimetype = content_types(path)
  #     # puts "--->#{mimetype}"
  #   end
  # end

  #
  # Organize Downloads
  #
  DOWNLOAD_TYPES = {
    '02 Apps' => %w(com.apple.application com.apple.installer-package-archive),
    '06 Docs' => %w(com.adobe.pdf public.rtf application/vnd.openxmlformats-officedocument.wordprocessingml.template public.log com.apple.iwork.pages.pages),
    '03 Archives' => %w(public.archive application/rar-compressed),
    '01 Design' => %w(com.adobe.photoshop-image com.adobe.illustrator.ai-image com.adobe.encapsulated-postscript com.adobe.indesign.indd-document),
    '04 Images' => 'public.image',
    '05 Scripts' => %w(public.source-code public.script public.html text/css),
    '09 Books' => %w(application/epub+zip),
    '08 Data' => %w(text/comma-separated-values com.microsoft.excel.xls)
  }
  DOWNLOAD_TYPES.each do |sub_dir, types|
    rule "Move downloaded #{sub_dir.downcase}" do
      puts "--------------------------------------------\n\033[36mMove downloaded #{sub_dir.downcase}\033[0m"
      move where_content_type(dir('~/Downloads/*.*'), types), mkdir("~/Downloads/#{sub_dir}")
    end
  end

  #
  # Clean Up Homebrew
  #
  rule 'Clean /Library/Caches/Homebrew/' do
    puts "--------------------------------------------\n\033[33mClean /Library/Caches/Homebrew/\033[0m"
    dir('/Library/Caches/Homebrew/*.tar.*').each do |path|
      trash path if File.mtime(path) < 90.days.ago
    end
    dir('/Library/Caches/Homebrew/*.tgz').each do |path|
      trash path if File.mtime(path) < 90.days.ago
    end
    dir('/Library/Caches/Homebrew/*.tbz').each do |path|
      trash path if File.mtime(path) < 90.days.ago
    end
  end


  # Cleaning up after Maid
  # ----------------------

  # This one should be after all the other 'Downloads' and 'Outbox' rules
  rule 'Remove empty directories && Kill Stupid .DS_Store files' do
    puts "--------------------------------------------\n\033[33mRemove empty directories && Kill Stupid .DS_Store files\033[0m"
    dir(%w(~/Downloads/**/.DS_Store ~/Dropbox/**/.DS_Store ~/Git/**/.DS_Store ~/Code/**/.DS_Store)).each do |path|
      File.delete(path)
    end
    dir(%w(~/Downloads/**/* ~/Dropbox/**/*)).each do |path|
      if File.directory?(path) && (Dir.entries(path) - %w{ . .. }).empty? && !path.match(/\.app/)
        trash path
      end
    end
  end

  # Trash
  rule 'Take out the Trash' do
    puts "--------------------------------------------\n\033[31mTake out the Trash\033[0m"
    dir('~/.Trash/*').each do |p|
      remove(p) if accessed_at(p) > 14.days.ago
    end
    puts '--------------------------------------------'
  end


end
