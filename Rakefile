require 'rake'

desc "Bind setting files to system"
task :install do
  #options
  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables = Dir.glob('*/**{.symlink}')

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"
    # puts "Checking for #{target}..."
    `echo "$PWD/#{linkable} #{target}"`


    if File.exists?(target) || File.symlink?(target) || File.exists?(File.expand_path(target)) || File.directory?(target) || File.symlink?(target)
      unless skip_all | overwrite_all | backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite | overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
      next if skip_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"`

  end
  target = "#{ENV["HOME"]}/.dotfilelocation"
   FileUtils.rm_rf(target) 
  `echo "DOTPATH='$PWD'" >> "$HOME"/.dotfilelocation`
  `echo "export DOTPATH;" >> "$HOME"/.dotfilelocation`
end

task :uninstall do

  Dir.glob('**/*.symlink').each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end

  end
end

task :default => 'install'
